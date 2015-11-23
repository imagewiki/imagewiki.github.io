angular.module "imagewikiFrontend"
  .controller "BulkEditController", [
    '$scope'
    '$stateParams'
    'AUTH_EVENTS'
    ($scope, $stateParams, AUTH_EVENTS) ->

      console.log 'EDITING IMAGES', $stateParams

      $scope.images = $stateParams.images

      $scope.$watch 'images', ->
        console.log 'IMAGES', $scope.images
        return

      $scope.updateImage = ->
        # ImageModel
        #   .updateImage(image)
        #   .then (data) ->
        #     console.log data
        #     toastr.success data.message, 'Success'
        #     return
        #   , ->
        #     toastr.error 'Something went wrong! Please contact our support team.', 'Error'
        #     return
        return

      return
  ]