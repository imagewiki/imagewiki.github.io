set_toggle_events = ($toggle, $field_block, $label) ->
  $toggle.bind 'showToggle', ->
    $toggle.show()
    $label.show()
    $field_block.hide()
    return
  $toggle.bind 'hideToggle', ->
    $toggle.hide()
    $label.hide()
    $field_block.show()
    return
  return

save_cancel_events = ($field_block, $toggle) ->
  $cancel = $field_block.find('.field-cancel')
  $save = $field_block.find('.field-save')
  # EVENT CLICK :: Cancel button is clicked
  $cancel.click ->
    $toggle.trigger 'showToggle'
    return
  # EVENT CLICK :: Save button is clicked
  $save.click ->
    update_object $toggle
    return
  return

format_date = ($container, $field) ->
  # Applies the Datepicker widget if has the class 'has-datepicker'
  if $container.hasClass('has-datepicker')
    classes = $container.attr('class')
    format = undefined
    if /dateformat\-/.test(classes)
      format = classes.match(/dateformat\-(\S+)|$/gm)
      format = format[0].replace('dateformat-', '')
    else
      format = '%d/%m/%Y'
    $field.datepicker format: format
  return

format_boolean = ($button, $label, $container, $field) ->
  # Applies the Switch widget is has the class 'is-boolean'
  if $container.hasClass('is-boolean')
    $field.hide().after $button
    if $label.text() == 'YES'
      $button.find('.btn-on').addClass 'active btn-primary'
    else if $label.text() == 'NO'
      $button.find('.btn-off').addClass 'active btn-primary'
    # EVENT CLICK :: Add the .active class to the clicked button and set the $field value to 'TRUE' or 'FALSE'
    $button.find('.btn').click ->
      value = if $(this).text() == 'YES' then 'TRUE' else 'FALSE'
      $field.val value
      $button.find('.btn').removeClass 'active btn-primary'
      $(this).addClass 'active btn-primary'
      return
  return

$(document).ready ->
  $('[data-toggle="popover"]').popover()
  $('[data-toggle="tooltip"]').tooltip()
  # ADD-EDIT Widget
  $('.add-edit-toggle').each ->
    $toggle = $(this)
    $container = $toggle.parent()
    $label = $container.find('.add-edit-label')
    $field_block = $container.find('.add-edit-field')
    $field = $field_block.find(':input.ownership_field')
    $button = $('<div class="btn-group btn-group-sm"></div>')
    $button.append('<button type="button" class="btn btn-default btn-on">YES</button>')
    $button.append('<button type="button" class="btn btn-default btn-off">NO</button>')
    format_date $container, $field
    format_boolean $button, $label, $container, $field
    # EVENT CLICK :: Toggle the Edit field is clicked
    $toggle.click ->
      # If it is a boolean widget then this will set the .btn-primary class to the correct button
      if $container.hasClass('is-boolean')
        $button.find('.btn').removeClass 'active btn-primary'
        if $label.text() == 'YES'
          $button.find('.btn-on').addClass 'active btn-primary'
        else if $label.text() == 'NO'
          $button.find('.btn-off').addClass 'active btn-primary'
        # Set field value
        value = if $label.text() == 'YES' then 'TRUE' else 'FALSE'
        $field.val value
      else if $label.text() != ''
        $field.val $label.text()
      if $field_block.is(':hidden')
        $toggle.trigger 'hideToggle'
        $field.focus()
      else
        $toggle.trigger 'showToggle'
      return
    # EVENT KEYUP :: Save when $field is hit by enter
    $field.keyup (e) ->
      if e.which == 13 and $field.val() != ''
        $label.html $field.val()
        $toggle.trigger 'showToggle'
        update_object $toggle
      return
    save_cancel_events $field_block, $toggle
    set_toggle_events $toggle, $field_block, $label

    ###*
    # The update_object function will be placed on different files.
    # This way images can be updated on different ways but still using this ADD-EDIT Widget without a need to change it or create a different one.
    # So we can use it to edit a single image or do a bulk edit with many more.
    ###

    return

  ###*
  # DMCA Takedown and violations flagging #52
  ###

  $('.image-violation-form, .image-violation-form *').click (e) ->
    e.stopPropagation()
    return
  $('.image-violation .link').click (event) ->
    event.preventDefault()
    event.stopPropagation()
    $('.image-violation-form:visible').fadeOut()
    $form = $(this).next()
    $form.stop(true, true).fadeToggle 'normal', ->
      if $form.is(':visible')
        $('body').not('.image-violation-form *').click ->
          $form.fadeOut()
          return
      return
    return
  $('.form-violations input:radio').change ->
    $('.form-violations input:submit').val('I would like to report ' + $(this).val()).show()
    $('.feedback-msg').text $(this).val() + ' reported!'
    return
  $('.form-violations input:submit').click (e) ->
    e.preventDefault()
    action = $('.form-violations').data('action')
    description = $('.form-violations textarea').val()
    reason = $('.form-violations input:radio:checked').val()
    $errors = $('.box-violations .errors')
    $.post action, {
      description: description
      reason: reason
    }, ((data) ->
      if data.status == 1
        $errors.hide()
        $('.form-violations').hide()
        $('.violations-feedback').show()
      else
        $errors.find('ul').empty()
        $.each data.errors.reason, (k, v) ->
          $errors.find('ul').append '<li>' + v + '</li>'
          return
        $errors.slideDown()
      return
    ), 'json'
    return
  # DMCA - end
  return
