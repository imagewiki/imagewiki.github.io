angular.module "imagewikiFrontend"
  .controller "BulkUploadController", [
    '$scope',
    'ImageUpload'
    ($scope, ImageUpload) ->

      $scope.$watch 'files', ->
        $scope.upload($scope.files)
        return

      $scope.upload = (files) ->
        if files && files.length
          for file in files
            ImageUpload
              .upload(file)
              .progress (evt) ->
                console.log('progress: ' + parseInt(100.0 * evt.loaded / evt.total) + '% file :'+ evt.config.file.name)
                return
              .success (data, status, headers, config) ->
                return
              .error (data, status, headers, config) ->
                return
        return


      return
  ]