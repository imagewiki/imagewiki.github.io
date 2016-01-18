angular.module "imagewikiFrontend"
  .controller "BulkUploadController", [
    '$scope'
    'BulkUploadService'
    'AUTH_EVENTS'
    ($scope, BulkUploadService, AUTH_EVENTS) ->

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

      $scope.$emit('fluidContainer')

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
        BulkUploadService.editImages $scope.selected
        return

      return
  ]