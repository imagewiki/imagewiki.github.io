angular.module "imagewikiFrontend"
  .controller "LogoutController", [
    '$scope',
    '$state',
    'UserAuth'
    ($scope, $state, UserAuth) ->

      UserAuth.logout()
      $rootScope.$broadcast AUTH_EVENTS.logoutSuccess
      $scope.setCurrentUser null

      $state.go('home')

      return
  ]