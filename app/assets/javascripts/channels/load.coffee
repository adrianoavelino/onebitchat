# Load messages getting the first channel
$(document).on 'turbolinks:load', ->
  channel_id = $('ul.channels li:first div a span').attr('id')
  current_user_id = $(".team_title").attr("data-user-id")
  if channel_id != undefined
    console.log 'load channel'
    $(".chat_name").attr('data-type', 'channels')
    $(".chat_name").attr('data-id', channel_id)
    $.post '/notifications', { notification:
      channel_id: channel_id
      current_user_id: current_user_id }, (data) ->
        document.querySelector('a.open_channel').style.fontWeight = "normal"
    window.open(channel_id, 'channels')

# Get channel messages when clicked
  $('body').on 'click', 'a.open_channel', (e) ->
    channel_id = $(".chat_name").attr('data-id')
    console.log 'click channel'
    if channel_id == e.target.id
      console.log 'repetido'
      e.preventDefault()
    else
      $.post '/notifications', { notification:
        channel_id: e.target.id
        current_user_id: current_user_id }, (data) ->
          console.log data

      $(".chat_name").attr('data-type', 'channels')
      $(".chat_name").attr('data-id', e.target.id)
      e.target.style.fontWeight = "normal"
      window.open(e.target.id, 'channels')
