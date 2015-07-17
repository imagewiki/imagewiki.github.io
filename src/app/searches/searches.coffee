upload_and_show_file = (element, event) ->
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

build_onload_callback = ->
  (e) ->
    image = e.target.result
    show_preview_image image
    $('#image-url').val ''
    return

show_overlay = ->
  $('.search-block .field .bg-overlay').show()
  return

toggle_thumbnail_preview = (field) ->
  timeout = undefined
  term = $(field).val()
  if term_is_url(term)
    set_option '#search_url'
  else
    set_option '#search_description'
    return
  if timeout
    clearTimeout timeout
    timeout = null
  if is_valid_url(term)
    if already_have_preview(term)
      return false
    show_error true
    show_overlay()
    timeout = setTimeout((->
      show_preview_image term
      timeout = null
      return
    ), 1000)
  else
    hide_image_preview()
    show_error false
  return

show_error = (show) ->
  if show
    $('.search-block .image-upload-error').addClass 'hidden'
    $('.search-block .field').removeClass 'has-error'
  else
    $('.search-block .image-upload-error').removeClass 'hidden'
    $('.search-block .field').addClass 'has-error'
  return

set_option = (activated_tab) ->
  toggle_fields activated_tab
  update_form_action()
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

toggle_fields = (tab) ->
  if tab == '#search_description' or tab == '#search_url'
    $('#search_description').show()
    $('#search_file').hide().val ''
  else
    $('#search_description').hide().val ''
    $('#search_file').show()
  return

update_form_action = ->
  $('#new_search').attr 'action', $('.home-tabs li.active a').data('path')
  return

term_is_url = (term) ->
  is_valid_url term

is_valid_url = (url) ->
  url.match /^.+\.(jpg|gif|png)/
  # REGEX => http://rubular.com/r/0zZtZ3t4SI

show_preview_image = (url) ->
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

already_have_preview = (url) ->
  $('.image-preview').attr('src') == url

hide_image_preview = ->
  $('.search-block .image-preview')
    .removeClass('fadeInDown')
    .addClass('fadeOutUp')
    .one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
      $(this).remove()
      return
  return

$(document).ready ->
  # $('#new_search').find('#search_url, #search_file').hide()
  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
    activated_tab = $(e.target).attr('href')
    set_option activated_tab
    return
  $('#search_description').keyup ->
    toggle_thumbnail_preview this
    return
  # .change(function(e){
  #   $(this).keyup();
  # });
  $('.browse-your-files').click ->
    $('#search_file').click()
    return
  $('#search_file').change (e) ->
    # $(".pull-left.button").click();
    upload_and_show_file $(this), e
    return
  return
