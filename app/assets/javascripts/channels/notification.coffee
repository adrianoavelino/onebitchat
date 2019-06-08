window.notification = (team_id) ->
  App.notification = App.cable.subscriptions.create { channel: "NotificationChannel", team_id: team_id },
    received: (data) ->
      chat_name_opened = $(".chat_name").text()
      chat_name_updated_from_websocket = data.slug

      is_chat_opened = (chat_current, chat_from_websocket) ->
        return chat_current == chat_from_websocket

      has_notification = (_chat_name, chat_from_websocket) ->
        return _chat_name == chat_from_websocket

      $('.open_channel').each (item) ->
        chat_name = this.text.trim().split("#")[1]
        if !is_chat_opened(chat_name_opened, chat_name_updated_from_websocket ) && has_notification(chat_name, chat_name_updated_from_websocket)
          this.style.fontWeight = 'bold'
