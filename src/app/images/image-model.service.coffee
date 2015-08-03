angular.module "imagewikiFrontend"
  .factory 'ImageModel', [
    '$http',
    'API_URL',
    'UserAuth'
    'Upload'
    ($http, API_URL, UserAuth, Upload) ->
      imageModel = {}

      # @TODO: Change this when the route to get user images is created
      imageModel.getUserImages = ->
        params = "collectionId=LatestInstagramPosts"

        $http.get("#{API_URL}/images?#{params}").then (res) ->
          res.data

      # @TODO: Uncomment the base code below to when the route to delete is ready
      imageModel.delete = (hashid) ->
        console.log 'Image deleted!'
        # params =
        #   hashid: hashid
        # $http.post("#{API_URL}/image/delete", params).then (res) ->
        #   res.data
        return

      imageModel.upload = (file) ->
        params =
          url: "#{API_URL}/images"
          file: file

        params.fields = { user_id: UserAuth.getUser().id } if UserAuth.isAuthenticated()

        Upload.upload params

      imageModel
  ]
