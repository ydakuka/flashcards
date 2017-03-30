$(document).ready ->
  $('#flickrSearch').hide()
  $('#flickrSearchFormLoad').on 'click', ->
    $('#uploadImage').hide()
    $('#flickrSearch').show()

  last_element = ""
  $(document).on 'click', '.currentFlickrImage', ->
    $(last_element).css 'border-style': 'none'
    $(this).css 'border': '5px solid #C1E0FF'
    current_url = $(this).attr('src')
    last_element = $(this)
    $('#card_remote_image_url').val(current_url)
    ahoy.track 'Clicked on flickr image, before save'
