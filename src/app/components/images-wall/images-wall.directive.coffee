angular.module "imagewikiFrontend"
  .directive 'imagesWall', [
    '$compile'
    '$timeout'
    'toastr'
    ($compile, $timeout, toastr)->
      restrict: 'E'
      templateUrl: 'app/components/images-wall/images-wall.html'
      scope:
        images: '='
        selector: '@'
        selectable: '='
      controller: ($scope, $element, $attrs, $transclude) ->
        $scope.selected = {}

        $scope.delete = (image) ->
          $scope.$parent.delete image
          return
        return
      link: (scope, element, attr) ->

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

        scope.selectImage = (image) ->
          return false if scope.selectable == false
          id = image.image_id
          if image in scope.$parent.selected
            scope.selected[id] = false
            scope.$parent.selected.remove image
          else
            scope.selected[id] = true
            scope.$parent.selected.push image

          # console.log 'SELECTED', scope.$parent.selected
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

        scope.$on 'ClearSelectedImages', (event) ->
          scope.selected = {}
          scope.$parent.selected = []
          return

        scope.$on 'RestartGallery', (event) ->
          $("##{scope.selector}").justifiedGallery 'destroy'
          galleryCreated = false
          $("##{scope.selector} .image").hide()

          toastr.info 'The gallery is reloading after the changes.', 'Loading Gallery',
            closeButton: true
            closeHtml: '<i class="fa fa-refresh"></i>'

          $timeout(->
            runGallery()
            $("##{scope.selector} .image").hide()
            return
          , 1000)
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

        return # END LINK
  ]