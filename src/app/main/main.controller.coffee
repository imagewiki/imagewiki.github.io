angular.module "imagewikiFrontend"
  .controller "MainController", ($timeout) ->
    vm = this
    activate = ->
      $timeout (->
        vm.classAnimation = 'rubberBand'
        return
      ), 4000
      return

    vm.awesomeThings = []
    vm.classAnimation = ''
    vm.creationDate = 1436794598489
    activate()
    return
