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

      $scope.saveImage = ->
        if $scope.imageForm.$dirty
          dirtyFields = []
          angular.forEach $scope.imageForm, (value, key) ->
            return if key[0] == '$'
            aux = {}
            aux[key] = value.$modelValue
            dirtyFields.push aux if value.$dirty
            return
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