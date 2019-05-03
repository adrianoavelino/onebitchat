$(document).on 'turbolinks:load', ->
  $(".add_channel").on 'click', (e) =>
    $('#add_channel_modal').modal('open')
    return false

  $('.add_channel_form').on 'submit', (e) ->
    debugger
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {
          channel: {
            slug: $('#channel_slug').val()
            team_id: $('#channel_team_id').val()
            user_id: $('#channel_user_id').val()
          }
        }
        success: (data, text, jqXHR) ->
          console.log jqXHR, data, text
          debugger
          window.add(data['slug'], data['id'], 'channel')
          window.open(data['id'], 'channels')
          Materialize.toast('Success in add Channel &nbsp;<b>:(</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          console.log jqXHR, textStatus, errorThrown
          debugger
          Materialize.toast('Problem in add Channel &nbsp;<b>:(</b>', 4000, 'red')

    $('#add_channel_modal').modal('close')
    return false
