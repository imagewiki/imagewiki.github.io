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
        if $scope.file? and Object.keys($scope.file).length > 0
          $scope.homeUpload($scope.file)
        return

      $scope.homeUpload = (file) ->
        ImageModel
          .upload(file)
          .progress (evt) ->
            return
          .success (data, status, headers, config) ->
            $state.go('image-ownership', { hashid: data.image_id })
            return
          .error (data, status, headers, config) ->
            return
        return
      return
  ]