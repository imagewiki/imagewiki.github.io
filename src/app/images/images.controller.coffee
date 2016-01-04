angular.module "imagewikiFrontend"
  .controller "ImagesController", [
    '$scope',
    '$state',
    '$stateParams',
    'toastr'
    'ImageModel'
    'ImagePromise'
    ($scope, $state, $stateParams, toastr, ImageModel, ImagePromise) ->
      $scope.image = {}
      $scope.saved = true

      # Get image by its HashID
      $scope.image         = ImagePromise.image
      $scope.originalImage = angular.copy(ImagePromise.image)

      $scope.$on 'imageChanged', ->
        $scope.saved = false
        return

      $scope.$on '$stateChangeStart', (event) ->
        unless $scope.saved #&& angular.equals($scope.image, $scope.originalImage)
          event.preventDefault() unless confirm('There are unsaved changes on the image. Are you sure you want to leave this page?')
        return

      $scope.updateImage = (image) ->
        if angular.equals(image, $scope.originalImage)
          toastr.warning 'No need of saving', 'The image is untouched.'
          return false

        fields = {}
        fields.image_id = image.image_id
        angular.forEach image, (value, key) ->
          fields[key] = value unless angular.equals(value, $scope.originalImage[key])
          return
        # console.log 'FIELDS', fields, image.platform_business_rules, $scope.originalImage.platform_business_rules

        ImageModel
          .updateImage(fields)
          .then (data) ->
            $scope.saved = true
            toastr.success 'Image updated.', 'Success'
            $scope.originalImage = angular.copy(image)
            return
          , ->
            toastr.error 'Something went wrong! Please contact our support team.', 'Error'
            return
        return

      $scope.isImageMissingInfo = (image) ->
        ImageModel.isMissingInfo image

      return
  ]