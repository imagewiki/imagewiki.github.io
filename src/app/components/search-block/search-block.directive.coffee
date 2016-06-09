angular.module "imagewikiFrontend"
  .directive 'searchBlock', [
    '$timeout'
    'FileHandler'
    'TempImageModel'
    ($timeout, FileHandler, TempImageModel) ->
        restrict: 'E'
        templateUrl: 'app/components/search-block/search-block.html'
        controller: 'SearchBlockController'
        controllerAs: 'searchBlock'
        link: (scope, element, attr) ->

          element.find('.has-tooltip').tooltip
            trigger: 'manual'
            placement: 'bottom'

          scope.$on 'showSearchTooltip', ->
            showTooltip()
            $timeout( ->
              hideTooltip()
              return
            , 20000)

          scope.$on 'hideSearchTooltip', ->
            hideTooltip()
            return

          showTooltip = ->
            element.find('.has-tooltip').tooltip 'show'
            return

          hideTooltip = ->
            element.find('.has-tooltip').tooltip 'hide'
            return

          scope.$watch 'url', ->
            if scope.url? and scope.url != '' and FileHandler.isValidUrl(scope.url)
              scope.searchImage scope.url, null
            return

          scope.$watch 'image', ->
            if scope.image?
              scope.searchImage null, scope.image
            return

          scope.searchImage = (url, image) ->
            if image?
              scope.upload image
            else if url? && url != '' && FileHandler.isValidUrl(url)
              scope.uploadUrl url
            else
              alert "Oops that's not an image url!"
            return

          scope.setOption = (option) ->
            scope.option = option
            scope.url = null if option == 'upload'
            return

          scope.previewImage = (url) ->
            scope.image = null
            return unless $('#preview-image').length
            if FileHandler.isValidUrl(url)
              element.find('.form-group').removeClass 'has-error'
              scope.setPreviewUrl url
            else
              element.find('.form-group').addClass 'has-error'
              scope.setPreviewUrl ''

            return

          return
  ]