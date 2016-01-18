angular.module "imagewikiFrontend"
  .controller "UserPanelController", [
    '$scope',
    '$rootScope',
    'AUTH_EVENTS',
    'UserAuth',
    'UserStore'
    ($scope, $rootScope, AUTH_EVENTS, UserAuth, UserStore) ->

      userLoginSuccess = (user) ->
        if user.error
          $rootScope.$broadcast AUTH_EVENTS.loginFailed, user
        else
          $rootScope.$broadcast AUTH_EVENTS.loginSuccess
          $scope.setCurrentUser user
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