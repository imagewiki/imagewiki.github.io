angular.module "imagewikiFrontend"
  .controller 'ApplicationController', [
    '$scope',
    'UserAuth'
    ($scope, UserAuth) ->
      $scope.currentUser = UserAuth.getUser()

      $scope.$watch 'currentUser', ->
        return

      $scope.isAuthenticated = ->
        UserAuth.isAuthenticated()
      $scope.setCurrentUser = (user) ->
        $scope.currentUser = user
        return

      return
  ]