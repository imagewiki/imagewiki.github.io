angular.module "imagewikiFrontend"
  .factory 'BulkUploadFactory', [
    '$rootScope'
    '$timeout'
    '$q'
    'toastr'
    'ImageModel'
    ($rootScope, $timeout, $q, toastr, ImageModel) ->
      bulkUpload = {}

      bulkUpload.getImages = ($scope) ->
        ImageModel
          .getUserImages()
          .then (data) ->
            $scope.images = data.user_images

            # Broadcast a event saying how many images should be loaded on the current page
            if $scope.images.length > 0
              total = if $scope.images.length > $scope.itemsPerPage then $scope.itemsPerPage else $scope.images.length
              $rootScope.$broadcast 'UpdateTotalImages',
                totalImages: total
            return
          , ->
            # Returns a empty array if the request fails
            $scope.images = []
            return
          return

      bulkUpload.upload = ($scope) ->
        $rootScope.$broadcast 'UpdateTotalImages', { totalImages: $scope.files.length} if $scope.files != null && $scope.files.length > 0
        angular.forEach $scope.files, (file, index, context) ->
          index         = index + 1
          file.aborted  = false
          file.progress = 0
          file.upload   = ImageModel.upload(file)

          # Process the image upload
          file.upload.then (res) ->
            data = res.data
            $scope.images.push data
            toastr.success "Image successfully uploaded:<br><strong>#{data.title}</strong>", 'Success'

            $scope.files.remove file

            $rootScope.$broadcast('ReloadGallery', {}) if context.length == 0
            return
          , (res) ->
            # If file is aborted will show a message saying so
            if file.aborted
              toastr.error "#{file.name} upload was aborted!", 'Abort!'
            else
              # Show a message if something went wrong with the upload process
              toastr.error "Something went wrong while uploading the file: <strong>#{file.name}</strong>.", 'Error'
            $scope.files.remove file
            return
          , (evt) ->
            # Handle the progress bar for the upload
            progress = evt.loaded * 100 / evt.total
            file.progress = progress
            return
          return
        return

      bulkUpload.delete = ($scope, image) ->
        if confirm 'Are you sure you want to delete this image?'
          ImageModel
            .delete(image.image_id)
            .then (data)->
              toastr.warning data.message

              $scope.images.remove image
              $rootScope.$broadcast 'RestartGallery'
              return
            , ->
              toastr.error 'Something went wrong... Please contact our support.'
              return
        return

      bulkUpload.deleteImages = ($scope) ->
        images = $scope.selected
        if images.length == 0
          toastr.error 'No images were selected', 'Error'
          return false

        if confirm "Are you sure you want to delete all #{images.length} selected images?"
          promises = []
          angular.forEach $scope.selected, (image, index) ->
            promises.push ImageModel.delete(image.image_id)
            return

          $q.all(promises)
            .then (data)->
              toastr.warning 'All images were deleted', 'Warning'

              angular.forEach $scope.selected, (image, index) ->
                $scope.images.remove image
                $scope.selected.remove image
                return

              $rootScope.$broadcast 'RestartGallery'
              $rootScope.$broadcast 'ClearSelectedImages'
              return
            , ->
              toastr.error 'Something went wrong... Please contact our support.',
                closeButton: true
                timeOut: 0
              return
        return

      bulkUpload
  ]
