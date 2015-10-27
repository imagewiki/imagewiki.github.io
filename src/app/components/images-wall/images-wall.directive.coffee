angular.module "imagewikiFrontend"
  .directive 'imagesWall', ->
    restrict: 'E'
    templateUrl: 'app/components/images-wall/images-wall.html'
    scope:
      images: '='
      selector: '@'
    controller: ($scope, $element, $attrs, $transclude) ->
      console.log 'Wall controller', $scope
      $scope.$watch 'images', ->
        console.log 'Watch bricks', $scope.images
        return
      return
    link: (scope, element, attr) ->
      scope.$on 'LastBrick', (event) ->
        wall = new freewall("##{scope.selector}")
        console.log 'WALL object', wall
        wall.reset
          selector: '.image',
          animate: true,
          onResize: ->
            wall.fitWidth()
            return

        wall.container.find('.image img').load ->
          wall.fitWidth()
          return
        return
      return

