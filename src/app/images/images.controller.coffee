angular.module "imagewikiFrontend"
  .controller "ImagesController", [
    '$scope',
    '$state',
    '$stateParams',
    'toastr'
    'ImageModel'
    ($scope, $state, $stateParams, toastr, ImageModel) ->
      $scope.image = {}

      # $scope.$watch 'image', ->
      #   console.log $scope.image
      #   return

      $scope.$on '$stateChangeStart', (event) ->

        unless angular.equals($scope.image, $scope.originalImage)
          event.preventDefault() unless confirm('There are unsaved changes on the image. Are you sure you want to leave this page?')

        return

      # $scope.debugImage = ->
      #   console.log $scope.image
      #   return

      $scope.updateImage = (image) ->
        if angular.equals($scope.image, $scope.originalImage)
          toastr.warning 'No need of saving', 'The image is untouched.'
          return false
        ImageModel
          .updateImage(image)
          .then (data) ->
            # console.log data
            toastr.success data.message, 'Success'
            return
          , ->
            toastr.error 'Something went wrong! Please contact our support team.', 'Error'
            return
        return

      # Get image by its HashID
      ImageModel
        .getImage($stateParams.hashid)
        .then (image) ->
          # console.log 'IMAGE', image
          $scope.image         = angular.copy(image)
          $scope.originalImage = angular.copy(image)
          return
        , ->
          toastr.error 'Fail to get image', 'Error!'
          return

      $scope.isImageMissingInfo = (image) ->
        ImageModel.isMissingInfo image

      return
  ]