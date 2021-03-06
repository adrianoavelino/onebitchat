$(document).on 'turbolinks:load', ->
  team_id = $('.team_id').val()
  console.log team_id
  App.notification = App.cable.subscriptions.create { channel: "NotificationChannel", team_id: team_id },
    connected: ->
      console.log 'subscribed notification'

    received: (data) ->
      console.log 'recebeu em notification'
      console.log data
      current_user_id = $(".team_title").attr("data-user-id")
      type = data.type
      chat_name_opened = $(".chat_name").text()
      chat_name_updated_from_websocket = data.slug

      is_chat_opened = (chat_current, chat_from_websocket) ->
        return chat_current == chat_from_websocket

      has_notification = (_chat_name, chat_from_websocket) ->
        return _chat_name == chat_from_websocket

      # debugger
      if is_chat_opened(chat_name_opened, chat_name_updated_from_websocket) || is_chat_opened(chat_name_opened, chat_name_updated_from_websocket[0]) || is_chat_opened(chat_name_opened, chat_name_updated_from_websocket[1])
        console.log 'atualiza notificação como visualizada'
        $.post '/notifications', { notification:
          message_id: data.message_id
          current_user_id: current_user_id }, (data) ->
            console.log data
            return

      if type == 'channels'
        console.log 'channels'
        $('.open_channel').each (item) ->
          chat_name = this.text.trim().split('#')[1]
          if !is_chat_opened(chat_name_opened, chat_name_updated_from_websocket )
            if has_notification(chat_name, chat_name_updated_from_websocket)
              this.style.fontWeight = 'bold'
      else
        console.log 'talks'
        $('.open_user').each (item) ->
          chat_name = this.text.trim()
          if chat_name_opened != chat_name_updated_from_websocket[1]
            if chat_name == chat_name_updated_from_websocket[0]
              this.style.fontWeight = 'bold'

    speak: (message) ->
      @perform 'speak', message: message
