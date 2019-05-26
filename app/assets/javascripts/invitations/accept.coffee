$(document).on 'turbolinks:load', ->
  $('.accept_user_form').each (f) ->
    $(this).submit (e) ->
      e.preventDefault()
      email = $(this).find('input')[3].value
      team_id = $(this).find('input')[2].value
      console.log email + team_id
      $.ajax '/team_users/',
          type: 'POST'
          dataType: 'json',
          data: {
            team_user: {
              email: email
              team_id: team_id
            }
          }
          success: (data, text, jqXHR) ->
            window.location.href = "/"+data.slug
          error: (jqXHR, textStatus, errorThrown) ->
            Materialize.toast('Problem in add User. The User ' + jqXHR.responseJSON.user_id[0] + '&nbsp;<b>:(</b>', 8000, 'red')
      return
    return false
