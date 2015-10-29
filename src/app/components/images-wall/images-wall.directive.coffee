angular.module "imagewikiFrontend"
  .directive 'imagesWall', ->
    restrict: 'E'
    templateUrl: 'app/components/images-wall/images-wall.html'
    scope:
      images: '='
      selector: '@'
    controller: ($scope, $element, $attrs, $transclude) ->
      return
    link: (scope, element, attr) ->

      loadedImages = 0

      runGallery = ->
        $("##{scope.selector}").justifiedGallery
          rowHeight : 200
          margins : 3
        return

      scope.changePage = (newPageNumber) ->
        # console.log 'NEW PAGE LOADED', newPageNumber
        loadedImages = 0
        return

      scope.$on 'ImageLoaded', (event) ->
        loadedImages++
        if loadedImages == $('.image', element).length
          # console.log 'ALL IMAGES LOADED'
          $('.image', element).addClass 'loaded'
          runGallery()
        return

      scope.$on 'LastBrick', (event) ->
        # console.log 'LAST BRICK'
        return
      return
