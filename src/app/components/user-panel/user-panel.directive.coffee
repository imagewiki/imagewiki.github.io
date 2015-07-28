angular.module "imagewikiFrontend"
  .directive 'userPanel', ->
    restrict: 'E'
    templateUrl: 'app/components/user-panel/user-panel.html'
    controller: 'UserPanelController'
    controllerAs: 'userPanel'
    bindToController: false
