angular.module "imagewikiFrontend"
  .controller "UserPanelController", [
    '$scope',
    '$rootScope',
    'AUTH_EVENTS',
    'UserAuth',
    'UserStore'
    ($scope, $rootScope, AUTH_EVENTS, UserAuth, UserStore) ->

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

      $scope.logout = ->
        UserAuth.logout()
        $rootScope.$broadcast AUTH_EVENTS.logoutSuccess
        $scope.setCurrentUser null
        return

      return
  ]