angular.module "imagewikiFrontend"
  .controller "EditableFieldController", [
    '$scope',
    '$element',
    '$attrs',
    'EditableFieldLabel'
    ($scope, $element, $attrs, EditableFieldLabel) ->


      $scope.block     = $scope.block || 'div'
      $scope.label     = EditableFieldLabel.formatLabel($scope.type, $scope.ngModel)
      $scope.textInput = $scope.type in ['text', 'password', 'email']
      $scope.value     = { initial: '' }

      $scope.$watch 'ngModel', ->
        $scope.label = EditableFieldLabel.formatLabel($scope.type, $scope.ngModel)
        $scope.value = { initial: angular.copy($scope.ngModel) }
        return

      # Datepicker onTimeSet
      $scope.onTimeSet = (newDate, oldDate) ->
        $scope.value.initial = moment(newDate).format('YYYY/MM/DD')
        return

      # --- Save/Cancel actions
      $scope.showField = false
      $scope.showEdit = ->
        $scope.showField = true
        return
      showLabel = ->
        $scope.showField = false
        return
      # Cancel
      $scope.cancelEdit = ->
        $scope.value = { initial: angular.copy($scope.ngModel) }
        $scope.$broadcast 'cancelEdit'
        showLabel()
        return
      # Save
      $scope.saveEdit = ->
        $scope.ngModel = angular.copy($scope.value.initial)
        $scope.$emit 'imageChanged'
        showLabel()
        return

      return
  ]