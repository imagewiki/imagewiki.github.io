angular.module "imagewikiFrontend"
  .directive 'imagesWall', ['$compile', '$timeout', ($compile, $timeout) ->
    restrict: 'E'
    templateUrl: 'app/components/images-wall/images-wall.html'
    scope:
      images: '='
      selector: '@'
    controller: ($scope, $element, $attrs, $transclude) ->
      return
    link: (scope, element, attr) ->
      scope.$on 'LastBrick', (event) ->
        return
      return
    ]