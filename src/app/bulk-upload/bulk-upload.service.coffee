angular.module "imagewikiFrontend"
  .service 'BulkUploadService', [
    '$rootScope'
    '$timeout'
    '$state'
    '$q'
    'ImageModel'
    ($rootScope, $timeout, $state, $q, ImageModel) ->
      selected = {}
      bulkUpload = {}

      hasImagesSelected = (images) ->
        if images.length == 0
          $rootScope.$broadcast 'showToastrMessage',
            type: 'error'
            message: 'No images were selected'
            title: 'Error'
          return false
        else
          return true

      bulkUpload.getImages = ($scope, page) ->
        ImageModel
          .getUserImages(page)
          .then (data) ->
            $scope.images = data.images

            # Broadcast a event saying how many images should be loaded on the current page
            if $scope.images.length > 0
              $rootScope.$broadcast 'UpdateTotalImages',
                totalImages: $scope.images.length
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
            $rootScope.$broadcast 'showToastrMessage',
              type: 'success'
              message: "Image successfully uploaded:<br><strong>#{data.title}</strong>"
              title: 'Success'

            $scope.files.remove file

            $rootScope.$broadcast('ReloadGallery', {}) if context.length == 0
            return
          , (res) ->
            # If file is aborted will show a message saying so
            if file.aborted
              $rootScope.$broadcast 'showToastrMessage',
                type: 'error'
                message: "#{file.name} upload was aborted!"
                title: 'Abort!'
            else
              # Show a message if something went wrong with the upload process
              $rootScope.$broadcast 'showToastrMessage',
                type: 'error'
                message: "Something went wrong while uploading the file: <strong>#{file.name}</strong>."
                title: 'Error'
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
              $rootScope.$broadcast 'showToastrMessage',
                type: 'warning'
                message: data.message

              $scope.images.remove image
              $rootScope.$broadcast 'RestartGallery'
              return
            , ->
              $rootScope.$broadcast 'showToastrMessage',
                type: 'error'
                message: 'Something went wrong... Please contact our support.'

              return
        return

      bulkUpload.deleteImages = ($scope) ->
        images = $scope.selected

        return false unless hasImagesSelected(images)

        if confirm "Are you sure you want to delete all #{images.length} selected images?"
          promises = []
          angular.forEach $scope.selected, (image, index) ->
            promises.push ImageModel.delete(image.image_id)
            return

          $q.all(promises)
            .then (data)->
              $rootScope.$broadcast 'showToastrMessage',
                type: 'warning'
                message: 'All images were deleted'
                title: 'Warning'

              angular.forEach $scope.selected, (image, index) ->
                $scope.images.remove image
                $scope.selected.remove image
                return

              $rootScope.$broadcast 'RestartGallery'
              $rootScope.$broadcast 'ClearSelectedImages'
              return
            , ->
              $rootScope.$broadcast 'showToastrMessage',
                type: 'error'
                message: 'Something went wrong... Please contact our support.'
                options:
                  closeButton: true
                  timeOut: 0
              return
        return

      bulkUpload.setSelected = (images) ->
        selected = images
        return

      bulkUpload.getSelected = ->
        selected

      bulkUpload.editImages = (images) ->

        return false unless hasImagesSelected(images)

        bulkUpload.setSelected images
        $state.go 'bulk-edit'
        return

      bulkUpload.updateImages = ($scope, image) ->
        promises = []
        angular.forEach $scope.images, (value, key) ->
          image.image_id = value.image_id
          # console.log 'IMAGE UPDATED FIELD', image
          promises.push ImageModel.updateImage(image)
          return

        $q.all(promises)
          .then (data)->
            $rootScope.$broadcast 'showToastrMessage',
              type: 'success'
              message: 'All images were updated'
              title: 'Warning'
            $scope.saved = true
            return
          , ->
            $rootScope.$broadcast 'showToastrMessage',
              type: 'error'
              message: 'Something went wrong... Please contact our support.'
              options:
                closeButton: true
                timeOut: 0
            return
        return

      bulkUpload
  ]
