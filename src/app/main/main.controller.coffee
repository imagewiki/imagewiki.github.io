angular.module "imagewikiFrontend"
  .controller "MainController", [
    '$scope'
    '$state'
    'ImageModel'
    'TempImageModel'
    ($scope, $state, ImageModel, TempImageModel) ->
      # TempImageModel.removeImages()

      setRandomImage = ->
        images = $scope.featuredCollection.collection_images
        $scope.featuredImage = images[Math.floor(Math.random() * images.length)]
        return

      $scope.featuredCollection = { collection_id: '', collection_images: []}

      ImageModel
        .getFeaturedImage()
        .then (collection) ->
          $scope.featuredCollection = collection
          return
        , (response) ->
          $scope.featuredCollection = { collection_id: 'fake', collection_images: []}
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