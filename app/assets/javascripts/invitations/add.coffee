$(document).on 'turbolinks:load', ->
  $(".invite_user").on 'click', (e) =>
    console.log 'invite'
    $('#invite_user_modal').modal('open')
    $('#invitation_team_id').val(e.target.id)
    return false

  $('.invite_user_form').on 'submit', (e) ->
    console.log 'intite form'
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: {
          invitation: {
            email: $('#invitation_email').val()
            team_id: $('#invitation_team_id').val()
            status: $('#invitation_status').val()
          }
        }
        success: (data, text, jqXHR) ->
          add(data.name, data.id, 'user')
          Materialize.toast('Success in invite the User &nbsp;<b>:(</b>', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problem in invite the User. The User ' + jqXHR.responseJSON + '&nbsp;<b>:(</b>', 8000, 'red')
    $('#invite_user_modal').modal('close')
    return false
