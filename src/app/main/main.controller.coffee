angular.module "imagewikiFrontend"
  .controller "MainController", [
    '$scope',
    '$state',
    'ImageModel',
    'FileHandler',
    'CollectionPromise'
    ($scope, $state, ImageModel, FileHandler, CollectionPromise) ->
      # $scope.directImage = {}
      # $scope.previewUrl = ''

      # $scope.$watch 'previewUrl', ->
      #   return if $scope.previewUrl == ''
      #   return

      # $scope.setPreviewUrl = (url) ->
      #   $scope.previewUrl = url
      #   return
      # $scope.previewImg = ($files, $file, $event, $rejectedFiles) ->
      #   return false unless $file?
      #   FileHandler.filePreviewUrl $file, (url) ->
      #     $scope.previewUrl = url
      #     return
      #   return

      setRandomImage = ->
        images = $scope.featuredCollection.collection_images
        $scope.featuredImage = images[Math.floor(Math.random() * images.length)]
        return

      $scope.featuredCollection = CollectionPromise.collection
      setRandomImage()

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