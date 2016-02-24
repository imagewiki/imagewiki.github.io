angular.module "imagewikiFrontend"
  .directive 'userForms', ->
    restrict: 'E'
    templateUrl: 'app/components/user-panel/user-forms.html'
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

      scope.hideForms = ->
        element.find('.user-guard-form:visible').fadeOut()
        return

      scope.$on 'showSignUpForm', ->
        element.find('.user-guard-form.create-account-form').fadeIn()
        return
      return
