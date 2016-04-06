angular.module "imagewikiFrontend"
  .directive 'imageViolation', [
    '$compile'
    '$timeout'
    'ImageModel'
    'vcRecaptchaService'
    ($compile, $timeout, ImageModel, vcRecaptchaService)->
      restrict: 'E'
      templateUrl: 'app/components/image-violation/image-violation.html'
      scope:
        imageId: '='
      controller: ($scope, $element, $attrs, $transclude) ->

        $scope.visible = false
        $scope.violation =
          reporter_user_id: null
          violation_comments: null
          violation_reason_id: null

        $scope.response = null
        $scope.widgetId = null
        $scope.model =
          key: '6LfZSxITAAAAAAbbOq-2PrbETzWZVbnjOIOJOy_E'

        $scope.violation['reporter_user_id'] = $scope.$parent.$parent.currentUser.id if $scope.$parent.$parent.currentUser

        $scope.setResponse = (response) ->
          $scope.response = response
          return

        $scope.setWidgetId = (widgetId) ->
          $scope.widgetId = widgetId
          return

        $scope.cbExpiration = ->
          $scope.response = null
          return

        $scope.reportViolation = (violation) ->
          if violation.violation_reason_id == null || violation.violation_reason_id == ''
            $scope.$emit 'showToastrMessage',
              type: 'error'
              message: 'You need to select a reason.'
              title: 'Error'
            return false

          if $scope.response == null
            $scope.$emit 'showToastrMessage',
              type: 'error'
              message: 'Please check the recaptcha.'
              title: 'Are your a robot?'
            return false

          ImageModel
            .reportViolation($scope.imageId, violation)
            .then (data) ->
              $scope.$emit 'showToastrMessage',
                type: 'success'
                message: data.message
                title: 'Success'
              resetViolation()
              return
            , ->
              $scope.$emit 'showToastrMessage',
                type: 'error'
                message: data.message
                title: 'Error'
              resetViolation()
              return
          return

        resetViolation = ->
          $scope.visible = false
          $scope.violation['violation_comments'] = null
          $scope.violation['violation_reason_id'] = null
          return

        return
      link: (scope, element, attr) ->
        element.find('[data-toggle="tooltip"]').tooltip()
        return # END LINK
  ]