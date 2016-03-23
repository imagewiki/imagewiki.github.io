angular.module "imagewikiFrontend"
  .controller "EditableFieldController", [
    '$scope',
    '$element',
    '$attrs',
    'EditableFieldFactory'
    ($scope, $element, $attrs, EditableFieldFactory) ->

      $scope.block     = $scope.block || 'div'
      $scope.textInput = $scope.type in ['text', 'password', 'email']
      $scope.datepicker_name = "#{$scope.name}-datepicker" if $scope.type == 'date'

      # Set initials values
      $scope.label = EditableFieldFactory.formatLabel($scope.type, $scope.name, $scope.ngModel)
      initial      = EditableFieldFactory.formatInitialValue($scope.name, angular.copy($scope.ngModel))
      $scope.value = { initial: initial }
      $scope.value.tags = $.unique(angular.copy(initial)) if $scope.type == 'array'

      $scope.$watch 'value.initial', ->
        return false if EditableFieldFactory.notChanged($scope.name, $scope.value.initial, $scope.ngModel)

        $scope.ngModel = EditableFieldFactory.formatValue($scope.name, angular.copy($scope.value.initial))
        $scope.label = EditableFieldFactory.formatLabel($scope.type, $scope.name, $scope.value.initial)
        $scope.$emit 'imageChanged'
        return

      $scope.$on 'beginImageEdition', (event, edit) ->
        if edit
          $scope.showEdit()
        else
          showLabel()
        return

      $scope.updateTags = ($tag) ->
        tags = []
        angular.forEach $scope.value.tags, (value, key) ->
          tags.push value.text
          return
        $scope.value.initial = tags
        return

      # Datepicker onTimeSet
      $scope.onTimeSet = (newDate, oldDate) ->
        $scope.value.initial = moment(newDate).format('YYYY/MM/DD')
        return

      # --- Save/Cancel actions
      $scope.showField = $scope.$parent.showFields || false
      $scope.showEdit = ->
        $scope.showField = true
        return
      showLabel = ->
        $scope.showField = false
        return
      # Cancel
      $scope.cancelEdit = ->
        $scope.value = { initial: angular.copy($scope.ngModel) }
        $scope.label = EditableFieldFactory.formatLabel($scope.type, $scope.name, $scope.value.initial)
        $scope.$broadcast 'cancelEdit'
        showLabel()
        return
      # Save
      $scope.saveEdit = ->
        showLabel()
        return

      return
  ]