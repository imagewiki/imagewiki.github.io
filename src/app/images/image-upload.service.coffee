angular.module "imagewikiFrontend"
  .factory 'ImageUpload', [
    '$http',
    'API_URL',
    'UserAuth'
    'Upload'
    ($http, API_URL, UserAuth, Upload) ->
      imageUpload = {}

      imageUpload.upload = (file) ->
        params =
          url: "#{API_URL}/images"
          file: file

        params.fields = { user_id: UserAuth.getUser().id } if UserAuth.isAuthenticated()

        Upload.upload params

      imageUpload
  ]
