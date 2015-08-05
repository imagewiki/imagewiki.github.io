angular.module "imagewikiFrontend"
  .directive 'editableField', ->
    restrict: 'E'
    templateUrl: 'app/components/editable-field/editable-field.html'
    scope:
      type: '=type'
      name: '=name'
      field: '=field'
      block: '=block'
    link: (scope, element, attr) ->
      element.find('.add-edit-block').wrap("<#{scope.block}></#{scope.block}>") unless scope.block == 'div'
      scope.oldValue = null

      # --- Save/Cancel actions
      scope.showField = false
      scope.showEdit = ->
        scope.oldValue = angular.copy(scope.field)
        scope.showField = true
        return
      showLabel = ->
        scope.showField = false
        return
      # Cancel
      scope.cancelEdit = ->
        scope.field = scope.oldValue
        showLabel()
        return
      # Save
      scope.saveEdit = ->
        scope.$parent.saveImage()
        showLabel()
        return


      return
    controller: 'EditableFieldController'
    controllerAs: 'editableField'
