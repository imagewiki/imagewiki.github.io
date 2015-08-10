angular.module "imagewikiFrontend"
  .factory 'FileHandler', [
    '$timeout'
    ($timeout) ->
      fileHandler = {}

      fileHandler.filePreviewUrl = (file, callback) ->
        reader = new FileReader()
        url = ''

        reader.onload = (e) ->
          $timeout ->
            callback e.target.result
            return
          return

        reader.readAsDataURL(file)
        return

      fileHandler.isValidUrl = (url) ->
        /^.+\.(jpg|gif|png)/.test url

      fileHandler
  ]