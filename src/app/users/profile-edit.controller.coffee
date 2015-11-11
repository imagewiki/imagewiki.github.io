angular.module "imagewikiFrontend"
  .controller "ProfileEditController", [
    '$scope'
    '$rootScope'
    '$state'
    'UserAuth'
    'toastr'
    ($scope, $rootScope, $state, UserAuth, toastr) ->

      unless UserAuth.isAuthenticated
        toastr.error 'You are not logged in', 'Unauthorized'
        $state.go 'home'

      userUpdateSuccess = (response) ->
        if response.status
          $scope.$parent.setCurrentUser($.extend($scope.$parent.currentUser, response.user))
          $rootScope.$broadcast 'UserUpdateSuccess'
          toastr.success 'Your info was successfully updated.', 'User info changed.'
        else
          $rootScope.$broadcast 'UserUpdateFail'
          toastr.error "#{response.error}", 'User update error.'
        return

      userUpdateFail = (response) ->
        $rootScope.$broadcast 'UserUpdateFail', response
        toastr.error "#{response.data.error}", 'User update error.'
        return

      $scope.user = $scope.$parent.currentUser

      UserAuth.fetchUser($scope.user.id).then (res) ->
        $scope.user = res.data
        $scope.$parent.setCurrentUser($.extend($scope.$parent.currentUser, res.data))
        return

      $scope.update = (user) ->
        toastr.info 'No changes made.', '' if $scope.profileEditForm.$pristine

        id = $scope.$parent.currentUser.id
        UserAuth
          .update(id, user)
          .then userUpdateSuccess, userUpdateFail
        return

      return
  ]