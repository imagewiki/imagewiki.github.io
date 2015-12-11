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

      $scope.user = angular.copy($scope.$parent.currentUser)

      $scope.update = (user) ->
        if $scope.profileEditForm.$pristine
          toastr.info 'No changes made.', ''
          return false

        id = $scope.$parent.currentUser.id
        UserAuth
          .update(id, user)
          .then (response) ->
            $scope.$parent.setCurrentUser($.extend($scope.$parent.currentUser, user))
            $rootScope.$broadcast 'UserUpdateSuccess'
            toastr.success 'Your info was successfully updated.', 'User info changed.'
            return
          , (response) ->
            $rootScope.$broadcast 'UserUpdateFail', response
            toastr.error "#{response.data.error}", 'User update error.'
            return
        return

      return
  ]