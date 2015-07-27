angular.module "imagewikiFrontend"
  .directive 'userPanel', ->
    restrict: 'E'
    templateUrl: 'app/components/user-panel/user-panel.html'
    controller: 'UserPanelController'
    controllerAs: 'userPanel'
    bindToController: true
    link: (scope, element, attr) ->
      element.find('.user-guard-form, .user-guard-form *').click (e) ->
        e.stopPropagation()
        return
      element.find('.user-guard .link').click (event) ->
        event.stopPropagation()
        element.find('.user-guard-form:visible').fadeOut()
        $form = $(this).next()
        $form.stop(true, true).fadeToggle 'normal', ->
          if $form.is(':visible')
            $('body').not('.user-guard-form *').click ->
              $form.fadeOut()
              return
          return
        return
      return