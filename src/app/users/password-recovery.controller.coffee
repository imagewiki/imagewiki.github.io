angular.module "imagewikiFrontend"
  .controller "PasswordRecoveryController", [
    '$scope'
    '$rootScope'
    '$state'
    'UserAuth'
    'toastr'
    ($scope, $rootScope, $state, UserAuth, toastr) ->
      $scope.user =
        email: null

      $scope.recover = (user) ->
        if user.email == null || user.email == ''
          toastr.error 'You need to inform your email.', 'Error'
          return false

        UserAuth
          .recoverPassword(user)
          .then (data) ->
            toastr.success data.message, 'Check your email'
            return
          , ->
            toastr.error data.message, 'Something went wrong.'
            return
        return

      return
  ]