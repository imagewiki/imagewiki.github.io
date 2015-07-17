angular.module "imagewikiFrontend"
  .run ($rootScope, $state, $stateParams, $log) ->
    $rootScope.$log = $log
    $rootScope.$on '$stateChangeStart', ->
      $rootScope.$state = $state