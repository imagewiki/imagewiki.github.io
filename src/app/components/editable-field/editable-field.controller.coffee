angular.module "imagewikiFrontend"
  .controller "EditableFieldController", [
    '$scope',
    '$element',
    '$attrs',
    'EditableFieldLabel'
    ($scope, $element, $attrs, EditableFieldLabel) ->

      $scope.block     = $scope.block || 'div'
      $scope.label     = EditableFieldLabel.formatLabel($scope.type, $scope.ngModel)
      $scope.value     = null
      $scope.textInput = $scope.type in ['text', 'password', 'email']

      $scope.$watch 'ngModel', ->
        $scope.label = EditableFieldLabel.formatLabel($scope.type, $scope.ngModel)
        $scope.value = angular.copy($scope.ngModel)
        return

      $scope.updateModel = (value) ->
        $scope.ngModel = value
        return

      return
  ]