angular.module "imagewikiFrontend"
  .directive 'iwContextMenu', ->
    directive =
      restrict: 'E'
      templateUrl: 'app/components/context-menu/context-menu.html'
