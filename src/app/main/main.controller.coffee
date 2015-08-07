angular.module "imagewikiFrontend"
  .controller "MainController", [
    '$scope',
    '$state',
    'ImageModel'
    ($scope, $state, ImageModel) ->
      $scope.directImage = {}

      # $scope.$watch 'file', ->
      #   # $scope.upload($scope.file) if $scope.file? and Object.keys($scope.file).length > 0
      #   return

      # $scope.upload = (file) ->
      #   ImageModel
      #     .upload(file)
      #     .progress (evt) ->
      #       return
      #     .success (data, status, headers, config) ->
      #       $state.go('image-ownership', { hashid: data.hashid })
      #       return
      #     .error (data, status, headers, config) ->
      #       return
      #   return
      return
  ]