angular.module "imagewikiFrontend"
  .controller "BulkEditController", [
    '$scope'
    '$state'
    '$timeout'
    'BulkUploadService'
    'TempImageModel'
    'AUTH_EVENTS'
    ($scope, $state, $timeout, BulkUploadService, TempImageModel, AUTH_EVENTS) ->

      $scope.$emit('fluidContainer')

      $scope.editing = true
      $scope.image   = TempImageModel.imageTemplate
      $scope.images  = BulkUploadService.getSelected()
      $scope.saved   = true

      $scope.$on AUTH_EVENTS.logoutSuccess, (event) ->
        $state.go 'home'
        return

      $scope.checkEditing = ->
        $timeout( ->
          $scope.$broadcast 'beginImageEdition', true
          return
        , 100)
        return

      $scope.$on 'imageChanged', ->
        $scope.saved = false
        return

      $scope.resetImage = ->
        $scope.image = TempImageModel.imageTemplate
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