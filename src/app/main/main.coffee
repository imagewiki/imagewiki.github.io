### LOADING FUNCTIONS ###

start_loading = ->
  $('.la-anim-10').addClass 'la-animate'
  return

stop_loading = ->
  $('.la-anim-10').removeClass 'la-animate'
  return

toasty = ->
  $('.toasty').addClass 'show'
  $('#toasty-sound')[0].play()
  setTimeout (->
    $('.toasty').removeClass 'show'
    return
  ), 1000
  return

get_params = ($toggle, $field, multiple_images) ->
  $image_data = $('#info_image')
  params = authenticity_token: $('input[name="authenticity_token"]').val()
  if typeof multiple_images == 'undefined'
    params['id'] = $image_data.data('id')
  else
    params['ids'] = $('#image_ids').val()
  model = $image_data.data('model')
  field = $toggle.data('field')
  value = $field.val()
  params[model] = {}
  if $toggle.data('relation')
    relation = $toggle.data('relation') + '_attributes'
    relation_id = $('#' + model.toLowerCase() + '_' + relation + '_id:hidden').val()
    params[model][relation] = id: relation_id
    params[model][relation][field] = value
  else
    params[model][field] = value
  params

$(document).ready ->
  # Open the Input File when click on a .add-image-direct class
  # and submit it after the user choose an image
  $(document).on 'click', '.add-image-direct', ->
    $('#frm_direct_image_creation').remove()
    $form = $('<form id="frm_direct_image_creation" action="/create-image" method="post" enctype="multipart/form-data" style="display: none"></form>')
    $form.append('<input type="file" name="image[file]" />')
    $form.appendTo 'body'
    $form.find('input').click()
    $form.find('input').change ->
      $form.submit()
      return
    return
  # Support for AJAX loaded modal window.
  # Focuses on first input textbox after it loads the window.
  $('[data-toggle="modal"]').click (e) ->
    e.preventDefault()
    url = $(this).attr('href')
    if url.indexOf('#') == 0
      $(url).modal 'open'
    else
      $.get(url, (data) ->
        $modal = $('#modal-container')
        $modal.find('.modal-content').html data
        $modal.modal()
        return
      ).success ->
        $('#modal-container').find('input:text:visible:first').focus()
        return
    return
  # Ownership Information Functions
  $('.ownership-list .field-cancel, .ownership-list .field-save').click ->
    $(this).parents('.add-edit-container').find('.add-edit-toggle').show()
    return
  $('.ownership-list span.add-edit-toggle').click ->
    $(this).hide()
    return
  cheet 't o a s t y', ->
    toasty()
    return
  # Alter action of form, for upload by icon camera
  $('.glyphicon.glyphicon-camera.icon-camera.browse-your-files').on 'click', ->
    action = $('a.browse-your-files.file-placeholder').data('path')
    $('form#new_search').attr 'action', action
    return
  return
