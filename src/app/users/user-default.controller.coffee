angular.module "imagewikiFrontend"
  .controller "UserDefaultController", [
    '$scope'
    '$rootScope'
    '$state'
    'toastr'
    'UserAuth'
    'UserDefaultsPromise'
    ($scope, $rootScope, $state, toastr, UserAuth, UserDefaultsPromise) ->

      unless UserAuth.isAuthenticated
        toastr.error 'You are not logged in', 'Unauthorized'
        $state.go 'home'

      $scope.userDefaults = UserDefaultsPromise
      $scope.showFields = true

      $scope.updateUserDefaults = (userDefaults) ->
        if $scope.userDefaultForm.$pristine
          toastr.info 'No changes made.', ''
          return false

        id = $scope.$parent.currentUser.id
        UserAuth
          .update(id, userDefaults)
          .then (response) ->
            toastr.success 'Your default values were successfully updated.', 'User defaults changed.'
            return
          , (response) ->
            $rootScope.$broadcast 'UserUpdateFail', response
            toastr.error "#{response.data.error}", 'User update error.'
            return
        return

      return
  ]