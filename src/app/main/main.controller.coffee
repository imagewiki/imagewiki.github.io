angular.module "imagewikiFrontend"
  .controller "MainController", [
    '$scope',
    '$state',
    'ImageModel',
    'FileHandler'
    ($scope, $state, ImageModel, FileHandler) ->
      # $scope.directImage = {}
      $scope.previewUrl = ''

      $scope.$watch 'previewUrl', ->
        return if $scope.previewUrl == ''
        return

      $scope.setPreviewUrl = (url) ->
        $scope.previewUrl = url
        return
      $scope.previewImg = ($files, $file, $event, $rejectedFiles) ->
        return false unless $file?
        FileHandler.filePreviewUrl $file, (url) ->
          $scope.previewUrl = url
          return
        return

      $scope.$watch 'file', ->
        $scope.upload($scope.file) if $scope.file? and Object.keys($scope.file).length > 0
        return

      $scope.upload = (file) ->
        ImageModel
          .upload(file)
          .progress (evt) ->
            return
          .success (data, status, headers, config) ->
            $state.go('image-ownership', { hashid: data.hashid })
            return
          .error (data, status, headers, config) ->
            return
        return
      return
  ]