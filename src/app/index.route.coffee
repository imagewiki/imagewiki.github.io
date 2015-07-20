angular.module "imagewikiFrontend"
  .config ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      # HOMEPAGE
      .state "home",
        url: "/"
        templateUrl: "app/main/homepage.html"
        controller: "MainController"
        controllerAs: "main"
      # Static Pages
      .state "about",
        url: "/about"
        templateUrl: "app/static-pages/about.html"
      .state "contact",
        url: "/contact"
        templateUrl: "app/static-pages/contact.html"
      .state "terms-of-use",
        url: "/terms-of-use"
        templateUrl: "app/static-pages/terms-of-use.html"
      .state "privacy-policy",
        url: "/privacy-policy"
        templateUrl: "app/static-pages/privacy-policy.html"
      .state "image-identification",
        url: "/image-identification"
        templateUrl: "app/static-pages/image-identification.html"
        data:
          topSearch: true
      .state "api",
        url: "/api"
        templateUrl: "app/static-pages/api.html"
      # Images
      .state "image-ownership",
        url: "/image-ownership"
        templateUrl: "app/images/image-ownership.html"
        controller: "ImagesController"
        controllerAs: "images"

    $urlRouterProvider.otherwise '/'
