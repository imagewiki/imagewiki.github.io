angular.module "imagewikiFrontend"
  .controller "PbrSelectController", [
    '$scope'
    '$element'
    '$attrs'
    'PbrSelectModel'
    ($scope, $element, $attrs, PbrSelectModel) ->

      $scope.options = PbrSelectModel.options

      return
  ]