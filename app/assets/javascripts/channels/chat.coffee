window.change_chat = (id, type, team_id) ->
  if App.chat != undefined
    App.chat.unsubscribe()

  App.chat = App.cable.subscriptions.create { channel: "ChatChannel", id: id , type: type, team_id: team_id},
    received: (data) ->
      window.add_message(data.message, data.date, data.name)
      console.log 'enviou mensagem'




# $(".chat_name").text()


# $(".open_channel")
#
#
# $(".open_channel").each(function(item){
# 	debugger
#   console.log(this.text)
# })
#
# this.style.fontWeight = 'bold'
