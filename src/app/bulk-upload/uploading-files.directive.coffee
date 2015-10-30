angular.module "imagewikiFrontend"
  .directive 'uploadingFiles', ->
    restrict: 'E'
    templateUrl: 'app/bulk-upload/uploading-files.html'
    scope:
      files: '='
      selector: '@'
    controller: ($scope, $element, $attrs, $transclude) ->
      return
    link: (scope, element, attr) ->

      loadedFiles = 0

      runGallery = ->
        $("##{scope.selector}").justifiedGallery
          rowHeight : 200
          margins : 3
        return

      scope.$on 'FilesChanged', (event) ->
        # console.log 'FILES CHANGED!!!!!!!!!!'
        loadedFiles = 0
        return

      scope.$on 'FileLoaded', (event) ->
        loadedFiles++
        if loadedFiles == scope.files.length
          # console.log 'ALL FILES LOADED'
          $('.image', element).addClass 'loaded'
          runGallery()
        return
      return
  .directive 'lastFile', ->
    restrict: 'A'
    link: (scope, element, attr) ->
      $('img', element).load ->
        scope.$emit 'FileLoaded',
          image: $(this)
          last: scope.$last
        return
      return