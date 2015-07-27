angular.module "imagewikiFrontend"
  .service 'Session', [
    'angular-storage'
    (store) ->

      @create = (key, data) ->
        store.set key, data
        return

      @get = (key) ->
        store.get key

      @destroy = (key) ->
        store.remove key
        return

      return
    ]