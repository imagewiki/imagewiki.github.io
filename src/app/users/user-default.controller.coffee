angular.module "imagewikiFrontend"
  .controller "UserDefaultController", [
    '$scope'
    '$rootScope'
    '$state'
    'UserAuth'
    'UserDefaultsPromise'
    ($scope, $rootScope, $state, UserAuth, UserDefaultsPromise) ->

      unless UserAuth.isAuthenticated
        $rootScope.$broadcast 'showToastrMessage',
          type: 'error'
          message: 'You are not logged in'
          title: 'Unauthorized'
        $state.go 'home'

      $scope.userDefaults = UserDefaultsPromise
      $scope.showFields = true

      $scope.updateUserDefaults = (userDefaults) ->
        if $scope.userDefaultForm.$pristine
          $rootScope.$broadcast 'showToastrMessage',
            type: 'info'
            message: 'No changes made.'
          return false

        id = $scope.$parent.currentUser.id
        UserAuth
          .update(id, userDefaults)
          .then (response) ->
            $rootScope.$broadcast 'showToastrMessage',
              type: 'success'
              message: 'Your default values were successfully updated.'
              title: 'User defaults changed.'
            return
          , (response) ->
            $rootScope.$broadcast 'UserUpdateFail', response
            $rootScope.$broadcast 'showToastrMessage',
              type: 'success'
              message: "#{response.data.error}"
              title: 'User update error.'
            return
        return

      return
  ]