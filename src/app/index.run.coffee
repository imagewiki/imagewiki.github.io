angular.module "imagewikiFrontend"
  .run [
    '$rootScope',
    '$state',
    '$stateParams',
    '$log'
    ($rootScope, $state, $stateParams, $log) ->
      $rootScope.$log = $log
      $rootScope.$on '$stateChangeStart', ->
        $rootScope.$state = $state
        $rootScope.$broadcast('resetContainer')

      # Add remove function to Arrays
      Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1
  ]