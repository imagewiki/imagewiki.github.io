angular.module "imagewikiFrontend"
  .controller "BulkEditController", [
    '$scope'
    '$stateParams'
    'BulkUploadService'
    'AUTH_EVENTS'
    ($scope, $stateParams, BulkUploadService, AUTH_EVENTS) ->

      $scope.images = BulkUploadService.getSelected()
      $scope.image = {}
      $scope.editing      = false

      $scope.toggleEdition = ->
        $scope.editing = !$scope.editing
        $scope.$broadcast 'beginImageEdition', $scope.editing
        return

      $scope.updateImage = (image) ->
        BulkUploadService.updateImages $scope, image
        return

      return
  ]