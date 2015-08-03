angular.module "imagewikiFrontend"
  .controller "BulkUploadController", [
    '$scope',
    'ImageModel'
    ($scope, ImageModel) ->

      $scope.images = []

      ImageModel.getUserImages()
        .then (images) ->
          $scope.images = images
          return
        , ->
          console.log 'FAIL TO GET IMAGES!'
          return


      $scope.$watch 'files', ->
        $scope.upload($scope.files)
        return

      $scope.upload = (files) ->
        if files && files.length
          for file in files
            ImageModel
              .upload(file)
              .progress (evt) ->
                console.log('progress: ' + parseInt(100.0 * evt.loaded / evt.total) + '% file :'+ evt.config.file.name)
                return
              .success (data, status, headers, config) ->
                $scope.images.push data
                return
              .error (data, status, headers, config) ->
                return
        return

      $scope.delete = (image) ->
        if confirm 'Are you sure you want to delete this image?'
          ImageModel.delete image.hashid
          index = $scope.images.indexOf(image)
          $scope.images.splice(index, 1)
          alert 'Image deleted'
        return


      return
  ]