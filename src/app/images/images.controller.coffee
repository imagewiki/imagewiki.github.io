angular.module "imagewikiFrontend"
  .controller "ImagesController", [
    '$scope',
    '$state',
    '$stateParams',
    'ImageModel'
    ($scope, $state, $stateParams, ImageModel) ->
      $scope.image = {}

      $scope.$watch 'image', ->
        console.log $scope.image
        return

      # Get image by its HashID
      ImageModel
        .getImage($stateParams.hashid)
        .then (image) ->
          $scope.image = image
          return
        , ->
          console.log 'Fail to get image'
          return

      $scope.isImageMissingInfo = (image) ->
        ImageModel.isMissingInfo image

      return
  ]