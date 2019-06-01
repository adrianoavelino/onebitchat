class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    m = message.messagable
    ActionCable.server.broadcast('notification', {
                                          message: message.body,
                                          slug: m.slug,
                                          date: message.created_at.strftime("%d/%m/%y"),
                                          name: message.user.name
                                        })
  end
end
