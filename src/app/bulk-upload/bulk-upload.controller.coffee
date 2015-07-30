angular.module "imagewikiFrontend"
  .controller "BulkUploadController", [
    '$scope',
    'API_URL',
    'Upload'
    ($scope, API_URL, Upload) ->

      $scope.$watch 'files', ->
        console.log $scope.files
        $scope.upload($scope.files)
        return

      $scope.upload = (files) ->
        if files && files.length
          for file in files
            Upload.upload
              url: "#{API_URL}/images"
              file: file
        return


      return
  ]