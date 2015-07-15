angular.module "imagewikiFrontend"
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state "home",
        url: "/"
        templateUrl: "app/main/main.html"
        controller: "MainController"
        controllerAs: "main"
        data:
          title: "The world's photo content id database"

    $urlRouterProvider.otherwise '/'
