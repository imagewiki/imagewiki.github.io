angular.module "imagewikiFrontend"
  .controller "BulkUploadController", [
    '$scope',
    '$timeout',
    'toastr',
    'ImageModel',
    'AUTH_EVENTS'
    ($scope, $timeout, toastr, ImageModel, AUTH_EVENTS) ->

      $scope.images = []
      $scope.files = []

      $scope.getImages = ->
        ImageModel
          .getUserImages()
          .then (data) ->
            $scope.images = data.user_images
            return
          , ->
            # console.log 'FAIL TO GET IMAGES!'
            return
        return

      if $scope.isAuthenticated()
        $scope.getImages()

      $scope.$on AUTH_EVENTS.loginSuccess, (event, data) ->
        $scope.getImages()
        return

      $scope.$on AUTH_EVENTS.logoutSuccess, (event, data) ->
        $scope.images = []
        return

      $scope.$watch 'files', ->
        $scope.upload()
        return

      $scope.upload = ->
        angular.forEach $scope.files, (file, index) ->
          index = index + 1
          file.progress = 0
          file.aborted = false
          # console.log index, file

          file.upload = ImageModel.upload(file)

          file.upload.then (res) ->
            # console.log 'SUCCESS', res
            data = res.data
            $scope.images.push data
            toastr.success "Image successfully uploaded:<br><strong>#{data.title}</strong>", 'Success'

            $scope.files.remove file
            # console.log $scope.files
            return
          , (res) ->
            # console.log res
            if file.aborted
              toastr.error "#{file.name} upload was aborted!", 'Abort!'
            else
              toastr.error "Something went wrong while uploading the file: <strong>#{file.name}</strong>.", 'Error'
            $scope.files.remove file
            return
          , (evt) ->
            progress = evt.loaded * 100 / evt.total
            file.progress = progress
            # console.log 'PROGRESS', index, progress, file.name, evt.config.file.name
            return
          return
        return

      $scope.delete = (image) ->
        if confirm 'Are you sure you want to delete this image?'
          ImageModel
            .delete(image.hashid)
            .then (data)->
              alert data
              return
            , ->
              alert 'Something went wrong... Please contact our support.'
              return
          index = $scope.images.indexOf(image)
          $scope.images.splice(index, 1)
        return


      return
  ]