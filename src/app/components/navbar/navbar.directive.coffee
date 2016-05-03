angular.module "imagewikiFrontend"
  .directive 'iwNavbar', ->
    directive =
      restrict: 'E'
      templateUrl: 'app/components/navbar/navbar.html'
      link: (scope, element, attr) ->
        scope.toggleOpenMenu = ->
          element.find('.menu').find('a.menu-icon, .navigation').toggleClass 'opened'
          return
        return
