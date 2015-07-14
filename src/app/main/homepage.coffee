$(document).ready ->
  $('section#homepage').each ->
    $('.upload-photo .button').click ->
      $('#direct-input-file').click()
      return

    $('#direct-input-file').change ->
      $('#direct_upload_form').attr('action', '/create-image').submit()
      return
    return

  return
