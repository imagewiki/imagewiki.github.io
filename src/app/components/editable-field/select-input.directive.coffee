angular.module "imagewikiFrontend"
  .directive 'selectInput', ->
    restrict: 'E'
    scope:
      name: '=name'
      field: '=field'
    templateUrl: 'app/components/editable-field/select-input.html'
    controller: 'SelectInputController'
    controllerAs: 'selectInput'
