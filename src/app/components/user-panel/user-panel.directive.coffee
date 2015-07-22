angular.module "imagewikiFrontend"
  .directive 'userPanel', ->
      restrict: 'E'
      controller: UserPanelController
      controllerAs: 'userPanel'
      bindToController: true
      templateUrl: 'app/components/user-panel/user-panel.html'
      link: (scope, element, attr) ->
        return