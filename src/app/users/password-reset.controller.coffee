angular.module "imagewikiFrontend"
  .controller "PasswordResetController", [
    '$scope'
    '$rootScope'
    '$state'
    '$stateParams'
    'UserAuth'
    'AUTH_EVENTS'
    ($scope, $rootScope, $state, $stateParams, UserAuth, AUTH_EVENTS) ->

      $scope.user = {}

      userLoginSuccess = (user) ->
        if user.error
          $rootScope.$broadcast 'showToastrMessage',
            type: 'error'
            message: user.error
            title: 'Error'
        else
          $rootScope.$broadcast AUTH_EVENTS.loginSuccess
          $scope.setCurrentUser user
          $state.go 'home'
        return

      userLoginFail = (reason) ->
        $rootScope.$broadcast AUTH_EVENTS.loginFailed, reason.data
        return

      $scope.resetPassword = (user) ->
        if user.password == null || user.password == '' || user.password_confirmation == null || user.password_confirmation == ''
          $rootScope.$broadcast 'showToastrMessage',
            type: 'error'
            message: 'You need to inform the new password.'
            title: 'Error'
          return false

        user.reset_password_token = $stateParams.reset_password_token

        UserAuth
          .resetPassword(user)
          .then userLoginSuccess, userLoginFail
        return

      return
  ]