angular.module "imagewikiFrontend"
  .factory 'ImageModel', [
    '$http',
    'API_URL',
    'UserAuth'
    'Upload'
    ($http, API_URL, UserAuth, Upload) ->
      imageModel = {}

      imageModel.getImage = (hashid) ->
        $http.get("#{API_URL}/images/#{hashid}?includeFields=all").then (res) ->
          res.data

      imageModel.isMissingInfo = (image) ->
        missing = []
        for attr, value in image
          missing.push attr unless value?

        if missing.length then false else true

      # @TODO: Change this when the route to get user images is created
      imageModel.getUserImages = ->
        params = ""
        params = "userId=#{UserAuth.getUser().id}" if UserAuth.isAuthenticated()

        $http.get("#{API_URL}/images?#{params}").then (res) ->
          JSON.parse(res.data)

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
