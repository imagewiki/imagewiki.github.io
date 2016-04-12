angular.module "imagewikiFrontend"
  .controller "PasswordRecoveryController", [
    '$scope'
    '$rootScope'
    '$state'
    'UserAuth'
    ($scope, $rootScope, $state, UserAuth) ->
      $scope.user =
        email: null

      $scope.recover = (user) ->
        if user.email == null || user.email == ''
          $rootScope.$broadcast 'showToastrMessage',
            type: 'error'
            message: 'You need to include your email.'
            title: 'Error'
          return false

        UserAuth
          .recoverPassword(user)
          .then (data) ->
            $rootScope.$broadcast 'showToastrMessage',
              type: 'success'
              message: data.message
              title: 'Check your email'
            return
          , ->
            $rootScope.$broadcast 'showToastrMessage',
              type: 'error'
              message: data.message
              title: 'Something went wrong'
            return
        return

      return
  ]