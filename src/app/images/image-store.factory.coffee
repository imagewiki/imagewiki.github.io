angular.module "imagewikiFrontend"
  .factory 'ImageStore', [
    'store'
    (store) ->
      store.getNamespacedStore('image')
  ]
