angular.module "imagewikiFrontend"
  .directive 'editableField', ->
    restrict: 'E'
    templateUrl: 'app/components/editable-field/editable-field.html'
    scope:
      type: '=type'
      field: '=field'
      block: '=block'
      image: '=image'
    link: (scope, element, attr) ->
      return
    controller: ($scope, $element, $attrs, $transclude) ->
      console.log $scope.$parent.image
      # $scope.image = $scope.$parent.image
      return



