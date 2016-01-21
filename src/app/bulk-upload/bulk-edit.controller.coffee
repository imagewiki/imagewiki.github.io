angular.module "imagewikiFrontend"
  .controller "BulkEditController", [
    '$scope'
    '$stateParams'
    'BulkUploadService'
    'AUTH_EVENTS'
    ($scope, $stateParams, BulkUploadService, AUTH_EVENTS) ->

      $scope.editing = false
      $scope.image   = {}
      $scope.images  = BulkUploadService.getSelected()
      $scope.saved   = true

      $scope.$on 'imageChanged', ->
        $scope.saved = false
        return

      $scope.resetImage = ->
        $scope.image = {}
        $scope.saved = true
        return

      $scope.toggleEdition = ->
        $scope.editing = !$scope.editing
        $scope.$broadcast 'beginImageEdition', $scope.editing
        return

      $scope.updateImage = (image) ->
        BulkUploadService.updateImages $scope, image
        return

      return
  ]