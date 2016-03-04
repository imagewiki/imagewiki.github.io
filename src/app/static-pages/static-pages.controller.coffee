angular.module "imagewikiFrontend"
  .controller "StaticPagesController", [
    '$scope'
    '$state'
    'toastr'
    ($scope, $state, toastr) ->
      if $state.current.name in ['image-identification', 'add-images']
        $scope.$emit 'fluidContainer'

      $scope.openSignUpForm = ->
        $(window).scrollTop(0)
        $scope.$parent.$broadcast 'showSignUpForm'
        return
      return
  ]
