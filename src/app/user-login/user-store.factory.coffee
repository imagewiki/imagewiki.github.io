angular.module "imagewikiFrontend"
  .factory 'UserStore', [
    'store'
    (store) ->
      store.getNamespacedStore('user')
  ]
