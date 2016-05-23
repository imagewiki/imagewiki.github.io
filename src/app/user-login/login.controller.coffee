angular.module "imagewikiFrontend"
  .controller "LoginController", [
    '$scope'
    '$rootScope'
    '$state'
    'AUTH_EVENTS'
    'UserAuth'
    ($scope, $rootScope, $state, AUTH_EVENTS, UserAuth) ->

      userLoginSuccess = (data) ->
        if data.error
          $rootScope.$broadcast AUTH_EVENTS.loginFailed, data
        else
          UserAuth
            .info()
            .then (user)->
              $scope.setCurrentUser user
              $rootScope.$broadcast AUTH_EVENTS.loginSuccess
              return
            , (res) ->
              $rootScope.$broadcast 'showToastrMessage',
                type: 'error'
                message: res.data
              return

          if $state.current.name == 'login'
            $rootScope.$broadcast 'showToastrMessage',
              type: 'success'
              message: 'You will be redirect to previous page now.'
            $state.go $rootScope.returnToState, $rootScope.returnToStateParams
        return

      userLoginFail = (reason) ->
        $rootScope.$broadcast AUTH_EVENTS.loginFailed, reason.data
        return

      $scope.credentials =
        email: ''
        password: ''

      $scope.user =
        first_name: ''
        last_name: ''
        email: ''
        password: ''
        password_confirmation: ''

      $scope.register = (user) ->
        UserAuth
          .register(user)
          .then userLoginSuccess, userLoginFail

        return

      $scope.login = (credentials) ->
        UserAuth
          .login(credentials)
          .then userLoginSuccess, userLoginFail
        return

      $scope.logout = ->
        UserAuth.logout()
        $rootScope.$broadcast AUTH_EVENTS.logoutSuccess
        $scope.setCurrentUser null
        return

      return
  ]