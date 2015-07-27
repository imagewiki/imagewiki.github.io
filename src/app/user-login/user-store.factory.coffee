angular.module "imagewikiFrontend"
  .factory 'UserStore', (store) ->
    store.getNamespacedStore('user')
