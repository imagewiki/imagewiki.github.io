angular.module "imagewikiFrontend"
  .factory 'TempImageModel', [
    '$q'
    '$rootScope'
    'ImageSelects'
    'PbrSelectModel'
    'ImageStore'
    'ImageModel'
    ($q, $rootScope, ImageSelects, PbrSelectModel, ImageStore, ImageModel) ->
      tempImageModel = {}

      imageData = {
        image_id: null
        title: null
        description: null
        publication_date: null
        creation_date: null
        location: null
        credit_byline: null
        is_r_rated: null
        is_rights_managed: null
        is_royalty_free: null
        model_release_info: null
        property_release_info: null
        plus_id: null
        license_type_id: null
        platform_business_rules: null
        reference_file_path: null
        keywords: []
        creator: {
          creator_name: null
          email: null
          site_url: null
        }
        licensing_rep: {
          is_exclusive: null
          is_active: null
          created_at: null
          licensing_rep_name: null
          site_url: null
        }
      }

      createImage = (file) ->
        data = angular.copy(imageData)
        data.title = file.name
        data

      fileToImage = (file) ->
        deferred = $q.defer()
        src = null
        reader = new FileReader()

        reader.onload = (e) ->
          deferred.resolve({file: e.target.result})

        reader.readAsDataURL(file)
        deferred.promise

      formatImageFields = (image) ->
        for key, value of image
          if key == 'license_type_id'
            option = ImageSelects.getOptionText(key, value)
            image[key] = option if option != false

        image

      cleanImageForUpdate = (image) ->
        fields = {}
        keys   = Object.keys(image).length
        nulls  = 0

        for key, value of image
          cleanValue = null
          if value is null
            nulls++
            continue

          if key == 'license_type_id'
            cleanValue = ImageSelects.getOptionId(key, value)
          else if value instanceof Array
            if value.length > 0
              cleanValue = value
            else
              nulls++
              continue
          else if typeof value is 'object'
            if key == 'licensing_rep' and value.licensing_rep_name == null
              nulls++
              continue
            cleanValue = cleanImageForUpdate(value)
            continue if cleanValue is false

          fields[key] = cleanValue || value

        return false if nulls == keys

        delete fields.image_id
        delete fields.reference_file_path

        fields

      tempImageModel.addImage = (file) ->
        image = createImage(file)
        image.image_id = "unsaved-image"

        fileToImage(file)
          .then (result) ->
            image.reference_file_path = result.file
            ImageStore.set 'image', image
            return

        image

      tempImageModel.updateImage = (image) ->
        image = formatImageFields(image)
        ImageStore.set 'image', image
        return

      tempImageModel.getImage = ->
        ImageStore.get 'image'

      tempImageModel.removeImage = ->
        ImageStore.remove 'image'
        return

      tempImageModel.hasImage = ->
        tempImageModel.getImage()?

      tempImageModel.uploadTempImage = ->
        image   = tempImageModel.getImage()
        promises = []
        cleanImage = cleanImageForUpdate image

        return false if cleanImage is false

        ImageModel
          .uploadUrl(image.reference_file_path)
          .then (data) ->
            cleanImage.image_id = data.image_id
            ImageModel
              .updateImage(cleanImage)
              .then (data2) ->
                $rootScope.$broadcast 'showToastrMessage',
                  type: 'success'
                  message: 'All your unsaved images were sent to our database'
                  title: 'Saved all images'
                tempImageModel.removeImage()
                return
            return
          , (response) ->
            return
        return

      tempImageModel
  ]
