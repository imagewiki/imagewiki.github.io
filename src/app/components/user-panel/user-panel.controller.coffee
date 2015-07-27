angular.module "imagewikiFrontend"
  .controller "UserPanelController", [
    '$scope',
    '$rootScope',
    'AUTH_EVENTS',
    'UserAuth'
    ($scope, $rootScope, AUTH_EVENTS, UserAuth) ->
      $scope.credentials =
        email: ''
        password: ''

      $scope.register = (user) ->
        # UserRegisterService
        #   .create

        return

      $scope.login = (credentials) ->
        UserAuth
          .login(credentials)
          .then (user) ->
            $rootScope.$broadcast AUTH_EVENTS.loginSuccess
            $scope.setCurrentUser user
            return
          , ->
            $rootScope.$broadcast AUTH_EVENTS.loginFailed
            return
        return

      return
  ]