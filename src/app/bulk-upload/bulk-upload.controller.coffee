angular.module "imagewikiFrontend"
  .controller "BulkUploadController", [
    '$scope'
    '$state'
    'BulkUploadService'
    'AUTH_EVENTS'
    ($scope, $state, BulkUploadService, AUTH_EVENTS) ->

      $scope.files        = []
      $scope.images       = []
      $scope.selected     = []
      $scope.itemsPerPage = 20

      $scope.getImages = ->
        BulkUploadService.getImages $scope
        return

      if $scope.isAuthenticated()
        $scope.getImages()

      $scope.$on AUTH_EVENTS.loginSuccess, (event, data) ->
        $scope.getImages()
        return

      $scope.$on AUTH_EVENTS.logoutSuccess, (event, data) ->
        $scope.images = []
        return

      $scope.$watch 'files', ->
        $scope.upload()
        return

      $scope.upload = ->
        BulkUploadService.upload $scope
        return

      $scope.delete = (image) ->
        BulkUploadService.delete $scope, image
        return

      $scope.deleteImages = ->
        BulkUploadService.deleteImages $scope
        return

      $scope.editImages = ->
        # console.log 'EDIT IMAGES', $scope.selected
        BulkUploadService.setSelected $scope.selected
        $state.go 'bulk-edit'
        return

      return
  ]