App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # debugger
    chat_name_current = $(".chat_name").text()
    chat_name_message = data.slug

    $('.open_channel').each (item) ->
      chat_name_sidebar = this.text.trim().split("#")[1]
      # debugger
      if chat_name_current != chat_name_message
        if chat_name_sidebar == chat_name_message
          this.style.fontWeight = 'bold'

  send_notification: (notification) ->
    @perform 'send_notification', notification: notification
