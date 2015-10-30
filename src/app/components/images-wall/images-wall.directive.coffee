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
      # console.log 'IMAGES WALL SCOPE', scope

      galleryCreated = false
      loadedImages   = 0
      totalImages    = 0

      scope.$on 'UpdateTotalImages', (event, args) ->
        totalImages = args.totalImages
        return

      runGallery = ->
        if galleryCreated
          # console.log 'UPDATE GALLERY'
          $("##{scope.selector}").justifiedGallery 'norewind'
        else
          # console.log 'START GALLERY'
          $("##{scope.selector}").justifiedGallery
            rowHeight : 200
            margins : 3
            maxRowHeight: 300

        $("##{scope.selector}").justifiedGallery().on 'jg.complete', (e) ->
          galleryCreated = true
          $('.image', element).addClass 'loaded'
          return
        return

      scope.$on 'FilesChanged', (event) ->
        # console.log 'IMAGES CHANGED!!!!!!!!!!'
        loadedImages = 0
        totalImages  = 0
        return

      scope.changePage = (newPageNumber) ->
        # console.log 'NEW PAGE LOADED', newPageNumber, scope.images.length
        loadedImages = 0
        totalPages  = Math.ceil(scope.images.length / scope.$parent.itemsPerPage)

        if newPageNumber == totalPages
          totalImages = scope.images.length % scope.$parent.itemsPerPage
        else
          totalImages = scope.$parent.itemsPerPage

        return

      scope.$on 'ReloadGallery', (event) ->
        # console.log 'RELOAD GALLERY'
        $("##{scope.selector}").justifiedGallery 'norewind'
        return

      scope.$on 'ImageLoaded', (event) ->
        loadedImages++
        # console.log loadedImages, totalImages
        runGallery()
        # if loadedImages == totalImages
        return
      return
