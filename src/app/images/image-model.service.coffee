angular.module "imagewikiFrontend"
  .factory 'ImageModel', [
    '$http',
    'API_URL',
    'UserAuth'
    'Upload'
    ($http, API_URL, UserAuth, Upload) ->
      imageModel = {}

      imageModel.getGreeting = (name) ->
        "Hello #{name}"

      imageModel.getImage = (hashid) ->
        $http.get("#{API_URL}/images/#{hashid}?includeFields=all").then (res) ->
          res.data

      imageModel.getFeaturedImage = ->
        featured = 'Frontpage Images'
        $http.get("#{API_URL}/images?collection_name=#{featured}").then (res) ->
          res.data

      imageModel.reportViolation = (image_id, violation) ->
        hashid = image_id
        $http.post("#{API_URL}/images/#{hashid}/violation", violation).then (res) ->
          res.data

      imageModel.updateImage = (image) ->
        hashid = image.image_id

        # Remove unnecessary params from request
        delete image.image_id
        delete image.reference_file_path

        $http.put("#{API_URL}/images/#{hashid}", image).then (res) ->
          res.data

      imageModel.isMissingInfo = (image) ->
        missing = []
        for attr, value in image
          missing.push attr unless value?

        if missing.length then false else true

      # @TODO: Change this when the route to get user images is created
      imageModel.getUserImages = (page) ->
        params = ""
        params += "user_id=#{UserAuth.getUser().id}" if UserAuth.isAuthenticated()
        params += "&page=#{page}" if page?

        $http.get("#{API_URL}/images?#{params}").then (res) ->
          res.data

      imageModel.delete = (hashid) ->
        params = "id=#{hashid}"
        $http.delete("#{API_URL}/images/#{hashid}").then (res) ->
          res.data

      imageModel.uploadUrl = (url) ->
        params =
          image_url: url

        params.user_id = UserAuth.getUser().id if UserAuth.isAuthenticated()

        $http.post("#{API_URL}/images", params).then (res) ->
          res.data

      imageModel.matchUrl = (url) ->
        params =
          image_url: url

        params.user_id = UserAuth.getUser().id if UserAuth.isAuthenticated()

        $http.post("#{API_URL}/match", params).then (res) ->
          res.data

      imageModel.upload = (file) ->
        params =
          url: "#{API_URL}/images"
          file: file

        params.fields = { user_id: UserAuth.getUser().id } if UserAuth.isAuthenticated()

        Upload.upload params

      imageModel.match = (file) ->
        params =
          url: "#{API_URL}/match"
          file: file

        params.fields = { user_id: UserAuth.getUser().id } if UserAuth.isAuthenticated()

        Upload.upload params

      imageModel
  ]
