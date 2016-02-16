angular.module "imagewikiFrontend"
  .controller "BulkUploadController", [
    '$scope'
    'BulkUploadService'
    'AUTH_EVENTS'
    ($scope, BulkUploadService, AUTH_EVENTS) ->

      $scope.files        = []
      $scope.images       = []
      $scope.selected     = []
      $scope.itemsPerPage = 50

      $scope.getImages = (page) ->
        BulkUploadService.getImages $scope, page
        return

      if $scope.isAuthenticated()
        $scope.getImages(1)

      $scope.$on AUTH_EVENTS.loginSuccess, (event, data) ->
        $scope.getImages(1)
        return

      $scope.$on AUTH_EVENTS.logoutSuccess, (event, data) ->
        $scope.images = []
        return

      $scope.$on 'ChangeUserImagesPage', (event, args) ->
        $scope.images = []
        $scope.getImages(args.page)
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