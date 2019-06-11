# Get talk messages when clicked
$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.open_user', (e) ->
    # window.notification($('.team_id').val(), 'talks')
    e.target.style.fontWeight = "normal"
    $(".chat_name").attr('data-type', 'talks')
    $(".chat_name").attr('data-id', e.target.id)
    window.open(e.target.id, 'talks')
