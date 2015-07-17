angular.module "imagewikiFrontend"
  .factory 'searchBlockHelper', ->

    # A bunch of functions that will manipulate the DOM to make the search block works
    # I'm too much lazy try to rearrange these fellas into separated services, so I'll just add 'em as a namespace helper locally
    util =
      upload_and_show_file: (element, event) ->
        if event.target.files.length == 0
          hide_image_preview()
          return
        $('#search_description').hide()
        element.show()
        show_overlay()
        if typeof FileReader == 'undefined'
          return true
        files = event.target.files
        f = undefined
        i = 0
        while i < files.length
          f = files[i]
          if f.type.match('image.*')
            reader = new FileReader
            reader.onload = build_onload_callback()
            reader.readAsDataURL f
          i++
        return

      is_upload_image: ($obj) ->
        path = $obj.val()
        if is_valid_url(path) then true else false

      build_onload_callback: ->
        (e) ->
          image = e.target.result
          util.show_preview_image image
          $('#image-url').val ''
          return

      show_overlay: ->
        $('.search-block .field .bg-overlay').show()
        return

      toggle_thumbnail_preview: (field) ->
        timeout = undefined
        term = $(field).val()
        util.set_option '#search_url'
        if timeout
          clearTimeout timeout
          timeout = null
        if is_valid_url(term)
          if already_have_preview(term)
            return false
          util.show_error true
          util.show_overlay()
          timeout = setTimeout((->
            util.show_preview_image term
            timeout = null
            return
          ), 1000)
        else
          util.hide_image_preview()
          util.show_error false
        return

      show_error: (show) ->
        if show
          $('.search-block .image-upload-error').addClass 'hidden'
          $('.search-block .field').removeClass 'has-error'
        else
          $('.search-block .image-upload-error').removeClass 'hidden'
          $('.search-block .field').addClass 'has-error'
        return

      set_option: (activated_tab) ->
        util.toggle_fields activated_tab
        util.update_form_action()
        $('a[href="' + activated_tab + '"]').tab 'show'
        if activated_tab == '#search_description'
          $('#search_description').attr 'name', 'search[description]'
          $('.search-block .image-upload-error').addClass 'hidden'
          $('.search-block .field').removeClass 'has-error'
          $('.search-block .image-preview')
            .removeClass('fadeInDown')
            .addClass('fadeOutUp')
            .one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
              $(this).remove()
              return
        else if activated_tab == '#search_url'
          $('#search_description').attr 'name', 'search[url]'
        return

      toggle_fields: (tab) ->
        if tab == '#search_description' or tab == '#search_url'
          $('#search_description').show()
          $('#search_file').hide().val ''
        else
          $('#search_description').hide().val ''
          $('#search_file').show()
        return

      update_form_action: ->
        $('#new_search').attr 'action', $('.home-tabs li.active a').data('path')
        return

      term_is_url: (term) ->
        util.is_valid_url term

      is_valid_url: (url) ->
        url.match /^.+\.(jpg|gif|png)/
        # REGEX => http://rubular.com/r/0zZtZ3t4SI

      show_preview_image: (url) ->
        $('.search-block .field .image-preview').remove()
        $previewImg = $('<img onload="$(\'.search-block .field .bg-overlay\').hide();" class="image-preview animated fadeInDown" />')

        # Add onError event
        onError  = '"$(\'.search-block .field .bg-overlay\').hide();'
        onError += '$(this).removeClass(\'fadeInDown\').addClass(\'flash\').attr(\'src\', \'/assets/imageNotFound400.jpg\')"'
        $previewImg.attr 'onerror', onError

        $('.search-block .field').append $previewImg
        if !/^https?/.test(url) and !/^data\:image/.test(url)
          url = 'http://' + url
        $previewImg.attr 'src', url
        return

      already_have_preview: (url) ->
        $('.image-preview').attr('src') == url

      hide_image_preview: ->
        $('.search-block .image-preview')
          .removeClass('fadeInDown')
          .addClass('fadeOutUp')
          .one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
            $(this).remove()
            return
        return


    # These are the only 3 functions that will be available when the service is injected as a dependency
    isUploadImage: util.is_upload_image
    isValidUrl: util.is_valid_url
    setOption: util.set_option
    toggleThumbnailPreview: util.toggle_thumbnail_preview
    uploadAndShowFile: util.upload_and_show_file
