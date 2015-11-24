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

      imageModel.updateImage = (image) ->
        hashid = image.image_id
        $http.put("#{API_URL}/images/#{hashid}", image).then (res) ->
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
          res.data

      imageModel.delete = (hashid) ->
        params = "id=#{hashid}"
        $http.delete("#{API_URL}/images/#{hashid}").then (res) ->
          res.data

      imageModel.uploadUrl = (url) ->
        params =
          imageUrl: url

        $http.post("#{API_URL}/images", params).then (res) ->
          res.data

      imageModel.upload = (file) ->
        params =
          url: "#{API_URL}/images"
          file: file
        params.fields = { userId: UserAuth.getUser().id } if UserAuth.isAuthenticated()

        Upload.upload params

      imageModel
  ]
