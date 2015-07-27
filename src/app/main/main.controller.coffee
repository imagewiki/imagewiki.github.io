angular.module "imagewikiFrontend"
  .controller "MainController", [
    '$scope',
    'UserStore'
    ($scope, UserStore) ->
      console.log UserStore.get 'user'
      return
  ]