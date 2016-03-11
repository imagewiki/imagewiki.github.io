angular.module "imagewikiFrontend"
  .directive 'userPanel', ->
    restrict: 'E'
    templateUrl: 'app/components/user-panel/user-panel.html'
    controller: 'LoginController'
    controllerAs: 'userPanel'
    bindToController: false
