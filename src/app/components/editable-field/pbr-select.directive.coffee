angular.module "imagewikiFrontend"
  .directive 'pbrSelect', ->
    restrict: 'E'
    scope:
      name: '=name'
      field: '=field'
    templateUrl: 'app/components/editable-field/pbr-select.html'
    controller: 'PbrSelectController'
    controllerAs: 'pbrSelect'
