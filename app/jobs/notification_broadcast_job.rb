class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    m = message.messagable
    chat_name = "notification_team_#{m.team.id}"
    ActionCable.server.broadcast(chat_name, {
                                          slug: m.slug
                                        })
  end
end
