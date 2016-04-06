angular.module "imagewikiFrontend"
  .directive 'imagesWall', [
    '$compile'
    '$timeout'
    ($compile, $timeout)->
      restrict: 'E'
      templateUrl: 'app/components/images-wall/images-wall.html'
      scope:
        images: '='
        selector: '@'
        selectable: '='
      controller: ($scope, $element, $attrs, $transclude) ->
        $scope.selected    = {}
        $scope.page        = 1
        $scope.isFirstPage = true
        $scope.isLastPage  = false

        $scope.$on 'UpdateTotalImages', (event, args) ->
          if args.totalImages < $scope.$parent.itemsPerPage
            $scope.isLastPage = true
          else
            $scope.isLastPage = false
          return

        $scope.$on 'ClearSelectedImages', (event) ->
          $scope.selected = {}
          $scope.$parent.selected = []
          return

        $scope.changePage = (newPageNumber) ->
          $scope.page = newPageNumber
          if newPageNumber == 1
            $scope.isFirstPage = true
          else
            $scope.isFirstPage = false
          $scope.$emit 'ChangeUserImagesPage',
            page: newPageNumber
          return

        $scope.selectImage = (image) ->
          return false if $scope.selectable == false
          id = image.image_id
          if image in $scope.$parent.selected
            $scope.selected[id] = false
            $scope.$parent.selected.remove image
          else
            $scope.selected[id] = true
            $scope.$parent.selected.push image
          return

        $scope.delete = (image) ->
          $scope.$parent.delete image
          return

        return

      # BEGIN LINK
      link: (scope, element, attr) ->

        galleryCreated = false

        runGallery = ->

          return

        scope.$on 'RestartGallery', (event) ->

          scope.$emit 'showToastrMessage',
            type: 'info'
            message: 'The gallery is reloading after the changes.'
            title: 'Loading Gallery'
            options:
              closeButton: true
              closeHtml: '<i class="fa fa-refresh"></i>'

          return

        scope.$on 'ReloadGallery', (event) ->
          return

        scope.$on 'ImageLoaded', (event) ->
          return

        return # END LINK
  ]