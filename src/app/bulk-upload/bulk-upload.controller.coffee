angular.module "imagewikiFrontend"
  .controller "BulkUploadController", [
    '$scope'
    '$state'
    'BulkUploadFactory'
    'AUTH_EVENTS'
    ($scope, $state, BulkUploadFactory, AUTH_EVENTS) ->

      $scope.files        = []
      $scope.images       = []
      $scope.selected     = []
      $scope.itemsPerPage = 20

      $scope.getImages = ->
        BulkUploadFactory.getImages $scope
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
        BulkUploadFactory.upload $scope
        return

      $scope.delete = (image) ->
        BulkUploadFactory.delete $scope, image
        return

      $scope.deleteImages = ->
        BulkUploadFactory.deleteImages $scope
        return

      $scope.editImages = ->
        console.log 'EDIT IMAGES', $scope.selected
        $state.go 'bulk-edit', { images: $scope.selected }
        return

      return
  ]