class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  def send_notification(data)
    ActionCable.server.broadcast 'notification', message: data['notification']
  end
end
