angular.module "imagewikiFrontend"
  .controller 'ApplicationController', ($scope, USER_ROLES, UserAuth) ->
    $scope.currentUser = null
    $scope.userRoles = USER_ROLES
    $scope.isAuthorized = UserAuth.isAuthorized

    $scope.setCurrentUser = (user) ->
      $scope.currentUser = user
      return

    return