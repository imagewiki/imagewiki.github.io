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
        console.log response
        $scope.$parent.setCurrentUser response
        $rootScope.$broadcast 'UserUpdateSuccess'
        toastr.success 'Your info was successfully updated.', 'User info changed.'
        return

      userUpdateFail = (reason) ->
        $rootScope.$broadcast 'UserUpdateFail', reason
        toastr.error "#{reason.data}", 'User update error.'
        return

      $scope.user = $scope.$parent.currentUser
      console.log 'CURRENT USER', $scope.$parent.currentUser

      UserAuth.fetchUser($scope.user.id).then (res) ->
        $scope.user = res.data
        $scope.$parent.setCurrentUser($.extend($scope.$parent.currentUser, res.data))
        return

      $scope.update = (user) ->
        console.log user, $scope.$parent.currentUser
        toastr.info 'No changes made.', '' if $scope.profileEditForm.$pristine

        id = $scope.$parent.currentUser.id
        UserAuth
          .update(id, user)
          .then userUpdateSuccess, userUpdateFail
        return

      return
  ]