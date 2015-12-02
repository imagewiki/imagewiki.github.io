angular.module "imagewikiFrontend"
  .controller "PasswordRecoveryController", [
    '$scope'
    '$rootScope'
    '$state'
    'UserAuth'
    'toastr'
    ($scope, $rootScope, $state, UserAuth, toastr) ->

      $scope.recover = (user) ->
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