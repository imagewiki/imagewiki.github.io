angular.module "imagewikiFrontend"
  .controller 'ApplicationController', [
    '$scope',
    'UserAuth'
    ($scope, UserAuth) ->
      $scope.currentUser = UserAuth.getUser()

      $scope.isAuthenticated = ->
        UserAuth.isAuthenticated()
      $scope.setCurrentUser = (user) ->
        $scope.currentUser = user
        return

      return
  ]