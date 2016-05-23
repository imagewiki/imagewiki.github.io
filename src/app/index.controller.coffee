angular.module "imagewikiFrontend"
  .controller 'ApplicationController', [
    '$scope'
    '$state'
    'toastr'
    'UserAuth'
    'AUTH_EVENTS'
    'MessageFormatter'
    'TempImageModel'
    ($scope, $state, toastr, UserAuth, AUTH_EVENTS, MessageFormatter, TempImageModel) ->
      $scope.currentUser = UserAuth.getUser()

      $scope.$watch 'currentUser', ->
        return

      # TempImageModel.removeImages()

      $scope.container_class = 'container'

      $scope.isAuthenticated = ->
        UserAuth.isAuthenticated()
      $scope.setCurrentUser = (user) ->
        $scope.currentUser = user
        return

      # Event Listeners
      $scope.$on 'showToastrMessage', (event, data) ->
        options = data.options || null
        title   = data.title   || null
        toastr[data.type](data.message, title, options)
        return
      $scope.$on 'reAuthenticate', (event, data) ->
        toastr.error data.message, 'Error'
        UserAuth.logout()
        $scope.setCurrentUser null
        $state.go 'login'
        return
      $scope.$on 'resetContainer', (event) ->
        $scope.container_class = 'container'
        return
      $scope.$on 'fluidContainer', (event) ->
        $scope.container_class = 'container-fluid'
        return
      $scope.$on AUTH_EVENTS.loginSuccess, (event) ->
        toastr.success 'Successfully logged in.', 'Success'

        if TempImageModel.hasImage()
          toastr.info "You have images unsaved. Now that you're logged in we will save them on our servers.", 'Uploading unsaved images',
            timeOut: 20000
          TempImageModel.uploadTempImage()

        return
      $scope.$on AUTH_EVENTS.logoutSuccess, (event) ->
        toastr.success 'Successfully logged out.', 'Success'
        return
      $scope.$on AUTH_EVENTS.loginFailed, (event, data) ->
        error_message = MessageFormatter.error data
        toastr.error error_message, 'Error'
        return

      return
  ]