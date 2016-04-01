angular.module "imagewikiFrontend"
  .controller "TempImageController", [
    '$scope',
    '$filter',
    '$state',
    '$stateParams',
    'ImageModel'
    'TempImageModel'
    ($scope, $filter, $state, $stateParams, ImageModel, TempImageModel) ->
      $scope.editing     = false
      $scope.image       = {}
      $scope.isTempImage = true
      $scope.saved       = true

      # Get image by its HashID
      images = TempImageModel.getImages()
      for img, index in images
        if img.image_id == $stateParams.hashid
          $scope.index         = index
          $scope.image         = img
          $scope.originalImage = angular.copy(img)
          break


      $scope.$on 'imageChanged', ->
        $scope.saved = false
        return

      $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
        return false if toState.name == 'login'
        unless $scope.saved #&& angular.equals($scope.image, $scope.originalImage)
          event.preventDefault() unless confirm('There are unsaved changes on the image. Are you sure you want to leave this page?')
        return

      $scope.toggleEdition = ->
        $scope.editing = !$scope.editing
        $scope.$broadcast 'beginImageEdition', $scope.editing
        return

      $scope.updateImage = (image) ->
        if angular.equals(image, $scope.originalImage)
          $scope.$emit 'showToastrMessage', { type: 'warning', message: 'No need of saving', 'The image is untouched.' }
          return false

        $scope.image = image
        TempImageModel.updateImage($scope.index, $scope.image)
        $scope.$emit 'showToastrMessage',
          type: 'warning'
          message: 'The data you entered was saved only locally. After you <strong>log in</strong> you can save your image on our database'

        $scope.saved = true
        $scope.toggleEdition()

        return

      $scope.resetImage = ->
        $scope.image = angular.copy($scope.originalImage)
        $scope.saved = true
        return

      return
  ]