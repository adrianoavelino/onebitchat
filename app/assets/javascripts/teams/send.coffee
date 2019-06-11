$(document).on 'turbolinks:load', ->
  $('.new_message').keypress (e) ->
    if e.which == 13 && e.shiftKey == false
      # window.notification($('.team_id').val(), 'talks')
      App.chat.send({message: $('.new_message').val()})
      $('.new_message').val("")
      return false
    return
