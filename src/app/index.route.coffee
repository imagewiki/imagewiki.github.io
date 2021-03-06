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
        .state "not-found",
          url: "/not-found"
          templateUrl: "app/main/not-found.html"
          controller: "NotFoundController"
          controllerAs: "notFound"
        # User
        .state "logout",
          url: "/logout"
          controller: "LogoutController"
        .state "login",
          url: "/login"
          templateUrl: "app/user-login/login.html"
          controller: "LoginController"
          data:
            hideUserPanel: true
        .state "signup",
          url: "/signup"
          templateUrl: "app/user-login/signup.html"
          controller: "LoginController"
          data:
            hideUserPanel: true
        .state "profile-edit",
          url: "/profile-edit"
          templateUrl: "app/users/profile-edit.html"
          controller: "ProfileEditController"
          controllerAs: "profileEdit"
        .state "user-default",
          resolve:
            UserDefaultsPromise: [
              '$q'
              '$state'
              '$stateParams'
              'UserAuth'
              ($q, $state, $stateParams, UserAuth) ->
                deferred = $q.defer()
                UserAuth
                  .userDefaults(UserAuth.getUser().id)
                  .then (data) ->
                    defaults = if data.data != null then data.data else {}
                    deferred.resolve({ default_values: defaults })
                    return
                  , ->
                    deferred.resolve({ default_values: {}})
                    return
                deferred.promise
            ]
          url: "/user-defaults"
          templateUrl: "app/users/user-default.html"
          controller: "UserDefaultController"
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
          url: "/mission"
          templateUrl: "app/static-pages/about.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
        .state "contact",
          url: "/contact"
          templateUrl: "app/static-pages/contact.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
        .state "terms-of-use",
          url: "/terms-of-use"
          templateUrl: "app/static-pages/terms-of-use.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
        .state "privacy-policy",
          url: "/privacy-policy"
          templateUrl: "app/static-pages/privacy-policy.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
        .state "image-identification",
          url: "/image-identification"
          templateUrl: "app/static-pages/image-identification.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
        .state "api",
          url: "/developers"
          templateUrl: "app/static-pages/api.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
        .state "add-images",
          url: "/add-images"
          templateUrl: "app/static-pages/add-images.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
        # Images
        .state "image-matches",
          url: "/image/matches"
          templateUrl: "app/images/matches.html"
          controller: "MatchesController"
          controllerAs: "matches"
        .state "temporary-image",
          url: "/temp-image"
          templateUrl: "app/images/image-ownership.html"
          controller: "TempImageController"
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
          url: "/my-images"
          templateUrl: "app/bulk-upload/bulk-upload.html"
          controller: "BulkUploadController"
          controllerAs: "bulkUpload"
        .state "bulk-edit",
          url: "/my-images/bulk-edit"
          templateUrl: "app/bulk-upload/bulk-edit.html"
          controller: "BulkEditController"
          controllerAs: "bulkEdit"

      $urlRouterProvider.otherwise '/'
  ]
