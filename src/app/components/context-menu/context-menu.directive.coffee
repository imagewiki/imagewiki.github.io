angular.module "imagewikiFrontend"
  .directive 'iwContextMenu', ->
    directive =
      restrict: 'E'
      templateUrl: 'app/components/context-menu/context-menu.html'
      link: (scope, element, attr) ->
        scope.toggleOpenMenu = ->
          element.find('.menu').find('a.menu-icon, .navigation').toggleClass 'opened'
          return
        return
