angular.module "imagewikiFrontend"
  .controller "BulkEditController", [
    '$scope'
    '$stateParams'
    'BulkUploadService'
    'AUTH_EVENTS'
    ($scope, $stateParams, BulkUploadService, AUTH_EVENTS) ->

      $scope.images = BulkUploadService.getSelected()
      $scope.image = {}

      $scope.updateImage = (image) ->
        BulkUploadService.updateImages $scope, image
        return

      return
  ]