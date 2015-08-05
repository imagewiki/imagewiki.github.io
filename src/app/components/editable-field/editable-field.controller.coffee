angular.module "imagewikiFrontend"
  .controller "EditableFieldController", [
    '$scope',
    '$element',
    '$attrs',
    '$transclude',
    '$sce'
    ($scope, $element, $attrs, $transclude, $sce) ->

      $scope.block = $scope.block || 'div'
      $scope.$watch 'field', ->
        return

      # --- Inpyt Types
      $scope.input = 'text'

      return
  ]