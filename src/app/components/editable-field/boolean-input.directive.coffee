angular.module "imagewikiFrontend"
  .directive 'booleanInput', ->
    restrict: 'E'
    scope:
      name: '=name'
      field: '=field'
    templateUrl: 'app/components/editable-field/boolean-input.html'
    controller: ($scope, $element, $attrs) ->
      $scope.updateModel = (value) ->
        $scope.$parent.$parent.updateModel value
        return

      return
    link: (scope, element, attr) ->

      scope.setFieldTrue = ->
        scope.field = 1
        return
      scope.setFieldFalse = ->
        scope.field = 0
        return
      return
