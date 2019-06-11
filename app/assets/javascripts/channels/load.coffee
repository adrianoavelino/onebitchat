# Load messages getting the first channel
$(document).on 'turbolinks:load', ->
  channel_id = $('ul.channels li:first div a span').attr('id')
  if channel_id != undefined
    # window.notification($('.team_id').val(), 'channels')
    $(".chat_name").attr('data-type', 'channels')
    $(".chat_name").attr('data-id', channel_id)
    window.open(channel_id, 'channels')

# Get channel messages when clicked
  $('body').on 'click', 'a.open_channel', (e) ->
    # window.notification($('.team_id').val(), 'channels')
    $(".chat_name").attr('data-type', 'channels')
    $(".chat_name").attr('data-id', e.target.id)
    e.target.style.fontWeight = "normal"
    window.open(e.target.id, 'channels')
