# Get talk messages when clicked
$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.open_user', (e) ->
    channel_id = $(".chat_name").attr('data-id')
    current_user_id = $(".team_title").attr("data-user-id")
    team_id = $('.team_id').val()
    console.log 'click channel'
    if channel_id == e.target.id
      e.preventDefault()
    else
      $.post '/notifications', { notification:
        member_id: e.target.id
        team_id: team_id
        current_user_id: current_user_id }, (data) ->
          console.log data

      e.target.style.fontWeight = "normal"
      $(".chat_name").attr('data-type', 'talks')
      $(".chat_name").attr('data-id', e.target.id)
      window.open(e.target.id, 'talks')
