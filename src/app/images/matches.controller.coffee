angular.module "imagewikiFrontend"
  .controller "MatchesController", [
    '$scope',
    '$state',
    'toastr'
    'MatchModel'
    ($scope, $state, toastr, MatchModel) ->
      $scope.results  = MatchModel.getResults()

      console.log $scope.results

      return
  ]
