angular.module "imagewikiFrontend"
  .directive 'brick', ->
    restrict: 'E'
    templateUrl: 'app/components/images-wall/brick.html'
    link: (scope, element, attr) ->
      scope.$emit('LastBrick') if scope.$last

      $(':checkbox', element).on 'click', ->
        if $(this).prop('checked')
          $('.image', element).addClass 'selected'
        else
          $('.image', element).removeClass 'selected'
        return
      $('.image', element).on 'mouseenter', ->
        return false if $(this).hasClass 'selected'
        $(this).find('.image-controls').addClass 'fadeInDown'
        $(this).find('.name-scroll').addClass 'fadeInUp'
        return
      $('.image', element).on 'mouseleave', ->
        return false if $(this).hasClass 'selected'
        $(this).find('.image-controls').removeClass 'fadeInDown'
        $(this).find('.name-scroll').removeClass 'fadeInUp'
        return
      return