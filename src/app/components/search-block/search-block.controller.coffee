angular.module "imagewikiFrontend"
  .controller "SearchBlockController", [
    '$scope',
    '$state',
    '$timeout',
    'ImageModel'
    ($scope, $state, $timeout, ImageModel) ->
      $scope.option = 'url'

      $scope.uploadUrl = (url) ->
        ImageModel
          .uploadUrl(url)
          .then (data) ->
            $state.go('image-ownership', { hashid: data.image_id })
            return
          , ->
            return
        return

      $scope.upload = (file) ->
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