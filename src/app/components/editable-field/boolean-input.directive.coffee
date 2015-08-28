angular.module "imagewikiFrontend"
  .directive 'booleanInput', ->
    restrict: 'E'
    scope:
      name: '=name'
      field: '=field'
    templateUrl: 'app/components/editable-field/boolean-input.html'
