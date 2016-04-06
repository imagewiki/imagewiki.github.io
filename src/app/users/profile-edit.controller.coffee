angular.module "imagewikiFrontend"
  .controller "ProfileEditController", [
    '$scope'
    '$rootScope'
    '$state'
    'UserAuth'
    ($scope, $rootScope, $state, UserAuth) ->

      unless UserAuth.isAuthenticated
        $rootScope.$broadcast 'showToastrMessage',
          type: 'error'
          message: 'You are not logged in'
          title: 'Unauthorized'
        $state.go 'home'

      $scope.user = angular.copy($scope.$parent.currentUser)

      $scope.update = (user) ->
        if $scope.profileEditForm.$pristine
          $rootScope.$broadcast 'showToastrMessage',
            type: 'info'
            message: 'No changes made.'
          return false

        id = $scope.$parent.currentUser.id
        UserAuth
          .update(id, user)
          .then (response) ->
            $scope.$parent.setCurrentUser($.extend($scope.$parent.currentUser, user))
            $rootScope.$broadcast 'UserUpdateSuccess'
            $rootScope.$broadcast 'showToastrMessage',
              type: 'success'
              message: 'Your info was successfully updated.'
              title: 'User info changed.'
            return
          , (response) ->
            $rootScope.$broadcast 'UserUpdateFail', response
            $rootScope.$broadcast 'showToastrMessage',
              type: 'error'
              message: "#{response.data.error}"
              title: 'User update error.'
            return
        return

      return
  ]