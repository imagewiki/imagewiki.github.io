angular.module "imagewikiFrontend"
  .directive 'brick', ->
    restrict: 'E'
    templateUrl: 'app/components/images-wall/brick.html'
    link: (scope, element, attr) ->
      scope.$emit('LastBrick') if scope.$last
      return

