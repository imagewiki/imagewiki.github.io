angular.module "imagewikiFrontend"
  .config [
    '$stateProvider'
    '$urlRouterProvider'
    ($stateProvider, $urlRouterProvider) ->
      $stateProvider
        # HOMEPAGE
        .state "home",
          resolve:
            CollectionPromise: [
              '$q'
              '$state'
              '$stateParams'
              'ImageModel'
              ($q, $state, $stateParams, ImageModel) ->
                deferred = $q.defer()
                ImageModel
                  .getFeaturedImage()
                  .then (collection) ->
                    deferred.resolve({collection: collection})
                    return
                  , (response) ->
                    deferred.resolve({collection: { collection_id: 'fake', collection_images: []}})
                    return
                deferred.promise
            ]
          url: "/"
          templateUrl: "app/main/homepage.html"
          controller: "MainController"
          controllerAs: "main"
          data:
            topSearch: true
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
          url: "/mission"
          templateUrl: "app/static-pages/about.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
          data:
            topSearch: true
        .state "contact",
          url: "/contact"
          templateUrl: "app/static-pages/contact.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
          data:
            topSearch: true
        .state "terms-of-use",
          url: "/terms-of-use"
          templateUrl: "app/static-pages/terms-of-use.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
          data:
            topSearch: true
        .state "privacy-policy",
          url: "/privacy-policy"
          templateUrl: "app/static-pages/privacy-policy.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
          data:
            topSearch: true
        .state "image-identification",
          url: "/image-identification"
          templateUrl: "app/static-pages/image-identification.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
          data:
            topSearch: true
        .state "api",
          url: "/developers"
          templateUrl: "app/static-pages/api.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
          data:
            topSearch: true
        .state "add-images",
          url: "/add-images"
          templateUrl: "app/static-pages/add-images.html"
          controller: "StaticPagesController"
          controllerAs: "staticPages"
          data:
            topSearch: true
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
