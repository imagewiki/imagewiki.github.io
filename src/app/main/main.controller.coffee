angular.module "imagewikiFrontend"
  .controller "MainController", [
    '$scope'
    '$state'
    'ImageModel'
    'TempImageModel'
    ($scope, $state, ImageModel, TempImageModel) ->
      # TempImageModel.removeImages()

      setRandomImage = ->
        images = $scope.featuredImages
        $scope.featuredImage = images[Math.floor(Math.random() * images.length)]
        return

      $scope.featuredImages = []

      $scope.$parent.$broadcast 'hideSearchTooltip'

      ImageModel
        .getFeaturedImage()
        .then (data) ->
          $scope.featuredImages = data.images
          return
        , (response) ->
          $scope.featuredImages = []
          return
        .finally setRandomImage


      $scope.reloadFeatured = ->
        setRandomImage()
        return

      $scope.openSignUpForm = ->
        $(window).scrollTop(0)
        $scope.$parent.$broadcast 'showSignUpForm'
        return

      $scope.$watch 'file', ->
        if $scope.file?
          TempImageModel.isTempImage = true
          $scope.homeUpload($scope.file)
        return

      $scope.homeUpload = (file) ->
        if $scope.currentUser == null
          $scope.$emit 'showToastrMessage',
            type: 'error',
            message: 'You must <strong>create an account</strong> or <strong>log in</strong> to save this image.'

          image = TempImageModel.addImage file

          $state.go 'temporary-image', { hashid: image.image_id }

        else
          ImageModel
            .upload(file)
            .progress (evt) ->
              return
            .success (data, status, headers, config) ->
              $state.go('image-ownership', { hashid: data.image_id })
              return
            .error (data, status, headers, config) ->
              return
        return
      return
  ]