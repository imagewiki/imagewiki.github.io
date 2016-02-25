angular.module "imagewikiFrontend"
  .controller 'ApplicationController', [
    '$scope',
    'toastr'
    'UserAuth'
    'AUTH_EVENTS'
    'MessageFormatter'
    ($scope, toastr, UserAuth, AUTH_EVENTS, MessageFormatter) ->
      # $scope.currentUser = UserAuth.getUser()

      $scope.$watch 'currentUser', ->
        return

      $scope.container_class = 'container'

      $scope.isAuthenticated = ->
        UserAuth.isAuthenticated()
      $scope.setCurrentUser = (user) ->
        $scope.currentUser = user
        return

      # Event Listeners
      $scope.$on 'resetContainer', (event) ->
        $scope.container_class = 'container'
        return
      $scope.$on 'fluidContainer', (event) ->
        $scope.container_class = 'container-fluid'
        return
      $scope.$on AUTH_EVENTS.loginSuccess, (event) ->
        toastr.success 'Successfully logged in.', 'Success'
        return
      $scope.$on AUTH_EVENTS.logoutSuccess, (event) ->
        toastr.success 'Successfully logged out.', 'Success'
        return
      $scope.$on AUTH_EVENTS.loginFailed, (event, data) ->
        error_message = MessageFormatter.error data
        toastr.error error_message, 'Error'
        return

      return
  ]