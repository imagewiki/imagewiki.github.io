angular.module "imagewikiFrontend"
  .controller "SearchBlockController", [
    '$scope',
    '$state',
    '$timeout',
    'ImageModel'
    ($scope, $state, $timeout, ImageModel) ->
      $scope.option = 'url'

      goToImage = (image_id) ->
        $state.go('image-ownership', { hashid: image_id })
        return

      $scope.uploadUrl = (url) ->
        ImageModel
          .matchUrl(url)
          .then (data) ->
            if data.match_result == 'no match found'
              ImageModel.uploadUrl(url).then (data2) ->
                goToImage data2.image_id
                return
            else
              goToImage data.image_id
            return
          , ->
            return
        return

      $scope.upload = (file) ->
        ImageModel
          .match(file)
          .progress (evt) ->
            return
          .success (data, status, headers, config) ->
            if data.match_result == 'no match found'
              ImageModel.upload(file).then (data2) ->
                goToImage data2.data.image_id
                return
            else
              goToImage data.image_id
            return
          .error (data, status, headers, config) ->
            return
        return
      return
  ]