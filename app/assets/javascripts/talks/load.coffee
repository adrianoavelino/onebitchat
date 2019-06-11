# Get talk messages when clicked
$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.open_user', (e) ->
    channel_id = $(".chat_name").attr('data-id')
    console.log 'click channel'
    if channel_id == e.target.id
      e.preventDefault()
    else
      e.target.style.fontWeight = "normal"
      $(".chat_name").attr('data-type', 'talks')
      $(".chat_name").attr('data-id', e.target.id)
      window.open(e.target.id, 'talks')
