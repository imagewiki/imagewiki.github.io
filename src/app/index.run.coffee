angular.module "imagewikiFrontend"
  .run ($rootScope, $state, $stateParams) ->
    $rootScope.$on '$stateChangeStart', ->
      $rootScope.$state = $state