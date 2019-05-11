$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.exit_team', (e) ->
    $('#leave_team_modal').modal('open')
    $('.exit_team_form').attr('action', 'team_users/' + e.target.id)
    $('#user_leave_team_id').val(e.target.id)
    return false

  $('.exit_team_form').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'DELETE'
        dataType: 'json',
        data: {team_id: $(".team_id").val(), id: $('#user_leave_team_id').val()}
        success: (data, text, jqXHR) ->
          window.location.href = "/"
        error: (jqXHR, textStatus, errorThrown) ->
          debugger
          Materialize.toast('Problem to exit from Team  &nbsp;<b>:(</b>', 4000, 'red')

    $('#leave_team_modal').modal('close')
    return false
