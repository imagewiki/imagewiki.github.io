angular.module "imagewikiFrontend"
  .directive 'customInput', ->
    restrict: 'E'
    scope:
      type: '=type'
      name: '=name'
      value: '=value'
    template: (tElement, tAttrs) ->
      console.log tElement, tAttrs
      '<div></div>'
