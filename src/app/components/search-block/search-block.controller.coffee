angular.module "imagewikiFrontend"
  .controller "SearchBlockController", [
    '$scope',
    '$state',
    '$timeout',
    'ImageModel'
    'TempImageModel'
    'MatchModel'
    ($scope, $state, $timeout, ImageModel, TempImageModel, MatchModel) ->
      $scope.option = 'url'

      goToImage = (image_id) ->
        $state.go('image-ownership', { hashid: image_id })
        return

      $scope.uploadUrl = (url) ->
        ImageModel
          .matchUrl(url)
          .then (data) ->
            if data.match_result == 'no match found'
              $scope.$emit 'showToastrMessage',
                type: 'warning'
                message: 'No match found.'
              TempImageModel.setNotFound url
              $state.go 'not-found'
            else
              MatchModel.setResults data.results
              $state.go 'image-matches'
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
              $scope.$emit 'showToastrMessage',
                type: 'warning'
                message: 'No match found.'
              TempImageModel.setNotFound file
              $state.go 'not-found'
            else
              MatchModel.setResults data.results
              $state.go 'image-matches'
            return
          .error (data, status, headers, config) ->
            return
        return
      return
  ]
