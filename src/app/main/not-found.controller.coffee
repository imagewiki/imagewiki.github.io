angular.module "imagewikiFrontend"
  .controller "NotFoundController", [
    '$scope'
    '$state'
    'ImageModel'
    'TempImageModel'
    ($scope, $state, ImageModel, TempImageModel) ->
      $scope.image = TempImageModel.getNotFound()

      $scope.uploadNotFound = (image) ->
        $scope.$emit 'showToastrMessage',
          type: 'info'
          message: 'The image will be uploaded.'
        ImageModel
          .uploadUrl(image)
          .then (data) ->
            $scope.$emit 'showToastrMessage',
              type: 'info'
              message: 'Be sure to fill out the data for the image.'
            $state.go 'image-ownership', { hashid: data.image_id }
            return
        return
      return
  ]