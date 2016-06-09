angular.module "imagewikiFrontend"
  .controller "ImagesController", [
    '$scope'
    '$state'
    '$timeout'
    'ImageModel'
    'ImagePromise'
    'AUTH_EVENTS'
    'TempImageModel'
    ($scope, $state, $timeout, ImageModel, ImagePromise, AUTH_EVENTS, TempImageModel) ->
      $scope.image = {}
      $scope.saved = true
      $scope.editing = false

      if TempImageModel.isTempImage
        $scope.origin = 'tryit'
        $timeout( ->
          $scope.$parent.$broadcast 'showSearchTooltip'
          return
        , 1000)

      # Get image by its HashID
      $scope.image         = ImagePromise.image
      $scope.originalImage = angular.copy(ImagePromise.image)

      $scope.$on AUTH_EVENTS.logoutSuccess, (event) ->
        $scope.$broadcast 'beginImageEdition', false
        return

      $scope.checkEditing = ->
        if $scope.isAuthenticated() and $scope.currentUser.id == $scope.image.user_id
          $timeout( ->
            $scope.$broadcast 'beginImageEdition', true
            return
          , 100)
        return

      $scope.$on 'imageChanged', ->
        $scope.saved = false
        return

      $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
        return false if toState.name == 'login'
        unless $scope.saved #&& angular.equals($scope.image, $scope.originalImage)
          event.preventDefault() unless confirm('There are unsaved changes on the image. Are you sure you want to leave this page?')
        TempImageModel.isTempImage = false
        return

      $scope.toggleEdition = ->
        $scope.editing = !$scope.editing
        $scope.$broadcast 'beginImageEdition', $scope.editing
        return

      $scope.updateImage = (image) ->
        if angular.equals(image, $scope.originalImage)
          $scope.$emit 'showToastrMessage',
            type: 'warning'
            message: 'No changes have been made, there is nothing to save.'
          return false

        fields = {}
        fields.image_id = image.image_id
        angular.forEach image, (value, key) ->
          fields[key] = value unless angular.equals(value, $scope.originalImage[key])
          return

        ImageModel
          .updateImage(fields)
          .then (data) ->
            $scope.saved = true
            $scope.$emit 'showToastrMessage',
              type: 'success'
              message: 'Image updated.'
              title: 'Success'
            $scope.originalImage = angular.copy(image)
            return
          , ->
            $scope.$emit 'showToastrMessage',
              type: 'error'
              message: 'Something went wrong! Please contact our support team.'
              title: 'Error'
            return
        return

      $scope.resetImage = ->
        $scope.image = angular.copy($scope.originalImage)
        $scope.saved = true
        return

      return
  ]