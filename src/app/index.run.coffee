angular.module "imagewikiFrontend"
  .run [
    '$rootScope'
    '$state'
    '$stateParams'
    '$log'
    '$window'
    '$location'
    'crazyegg'
    ($rootScope, $state, $stateParams, $log, $window, $location, crazyegg) ->
      $rootScope.$log = $log

      crazyegg.initCrazyEgg('00209233')

      $window.ga('create', 'UA-45654397-1', 'auto')

      $rootScope.$on '$stateChangeStart', (e, toState, toParams, fromState, fromParams)->
        $rootScope.$state = $state
        $rootScope.$broadcast('resetContainer')

        $window.ga('send', 'pageview', $location.path())

        if toState.name == 'login'
          if $rootScope.$$childHead.isAuthenticated()
            e.preventDefault()
            $rootScope.$broadcast 'showToastrMessage',
              type: 'info',
              message: 'You\'re already logged in.'
            $state.go 'home'

          if fromState.name != ''
            $rootScope.returnToState = fromState
            $rootScope.returnToStateParams = fromParams
          else
            $rootScope.returnToState = 'home'
            $rootScope.returnToStateParams = {}

      # Add remove function to Arrays
      Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1
  ]