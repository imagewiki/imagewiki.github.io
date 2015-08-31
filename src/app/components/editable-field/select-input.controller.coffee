angular.module "imagewikiFrontend"
  .controller "SelectInputController", [
    '$scope',
    '$element',
    '$attrs',
    'ImageSelects'
    ($scope, $element, $attrs, ImageSelects) ->
      $scope.options = ImageSelects.getSelectOptions($scope.name)
      return
  ]