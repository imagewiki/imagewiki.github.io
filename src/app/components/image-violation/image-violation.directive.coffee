angular.module "imagewikiFrontend"
  .directive 'imageViolation', [
    '$compile'
    '$timeout'
    'toastr'
    'ImageModel'
    ($compile, $timeout, toastr, ImageModel)->
      restrict: 'E'
      templateUrl: 'app/components/image-violation/image-violation.html'
      scope:
        imageId: '='
      controller: ($scope, $element, $attrs, $transclude) ->
        console.log 'SCOPE', $scope
        $scope.visible = false
        $scope.violation =
          reporter_user_id: $scope.$parent.$parent.currentUser.id
          violation_comments: null
          violation_reason_id: null

        $scope.reportViolation = (violation) ->
          console.log 'VIOLATION', violation
          ImageModel
            .reportViolation($scope.imageId, violation)
            .then (data) ->
              toastr.success data.message, 'Success'
              resetViolation()
              return
            , ->
              toastr.success data.message, 'Error'
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