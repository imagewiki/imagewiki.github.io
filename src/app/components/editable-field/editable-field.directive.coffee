angular.module "imagewikiFrontend"
  .directive 'editableField', ->
    restrict: 'E'
    templateUrl: 'app/components/editable-field/editable-field.html'
    scope:
      ngModel: '='
      type: '=type'
      name: '=name'
      block: '=?block'
    controller: 'EditableFieldController'
    controllerAs: 'editableField'
    link: (scope, element, attr) ->
      element.find('.add-edit-block').wrap("<#{scope.block}></#{scope.block}>") unless scope.block == 'div'
      return
