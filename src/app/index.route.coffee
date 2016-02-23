angular.module "imagewikiFrontend"
  .config [
    '$stateProvider'
    '$urlRouterProvider'
    ($stateProvider, $urlRouterProvider) ->
      $stateProvider
        # HOMEPAGE
        .state "home",
          url: "/"
          templateUrl: "app/main/homepage.html"
          controller: "MainController"
          controllerAs: "main"
        # User
        .state "logout",
          url: "/logout"
          controller: "LogoutController"
        .state "profile-edit",
          url: "/profile-edit"
          templateUrl: "app/users/profile-edit.html"
          controller: "ProfileEditController"
          controllerAs: "profileEdit"
        .state "password-recovery",
          url: "/password-recovery"
          templateUrl: "app/users/password-recovery.html"
          controller: "PasswordRecoveryController"
          controllerAs: "passwordRecovery"
        .state "password-reset",
          url: "/password-reset/:reset_password_token"
          templateUrl: "app/users/password-reset.html"
          controller: "PasswordResetController"
          controllerAs: "passwordReset"
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
        .state "image-matches",
          url: "/image/matches"
          templateUrl: "app/images/matches.html"
          controller: "MatchesController"
          controllerAs: "matches"
        .state "image-ownership",
          resolve:
            ImagePromise: [
              '$q'
              '$state'
              '$stateParams'
              'toastr'
              'ImageModel'
              ($q, $state, $stateParams, toastr, ImageModel) ->
                deferred = $q.defer()
                ImageModel
                  .getImage($stateParams.hashid)
                  .then (image) ->
                    deferred.resolve({image: image})
                    return
                  , (response) ->
                    toastr.error 'Fail to get image', 'Error!'
                    $state.go 'home'
                    deferred.reject()
                    return
                deferred.promise
            ]
          url: "/image-ownership/:hashid"
          templateUrl: "app/images/image-ownership.html"
          controller: "ImagesController"
          controllerAs: "images"
        .state "bulk-upload",
          url: "/bulk-upload"
          templateUrl: "app/bulk-upload/bulk-upload.html"
          controller: "BulkUploadController"
          controllerAs: "bulkUpload"
          data:
            topSearch: true
        .state "bulk-edit",
          url: "/bulk-edit"
          templateUrl: "app/bulk-upload/bulk-edit.html"
          controller: "BulkEditController"
          controllerAs: "bulkEdit"
          data:
            topSearch: true

      $urlRouterProvider.otherwise '/'
  ]
