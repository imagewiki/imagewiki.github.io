angular.module "imagewikiFrontend"
  .directive 'brick', ->
    restrict: 'A'
    link: (scope, element, attr) ->
      $('img', element).load ->
        if $(this).hasClass 'loaded'
          # console.log 'IMAGE ALREADY LOADED!!!!!!!!'
        else
          # console.log 'IMAGE LOADED', this
          $(this).addClass 'loaded'
          scope.$emit 'ImageLoaded',
            image: $(this)
            last: scope.$last
        return

      $(':checkbox', element).on 'click', ->
        if $(this).prop('checked')
          element.addClass 'selected'
        else
          element.removeClass 'selected'
        return
      element.on 'mouseenter', ->
        return false if $(this).hasClass 'selected'
        $(this).find('.image-controls').addClass 'fadeInDown'
        $(this).find('.name-scroll').addClass 'fadeInUp'
        return
      element.on 'mouseleave', ->
        return false if $(this).hasClass 'selected'
        $(this).find('.image-controls').removeClass 'fadeInDown'
        $(this).find('.name-scroll').removeClass 'fadeInUp'
        return
      return