class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_team_#{params[:team_id]}"
    # stream_from "notification"
  end

  def speak(data)
    ActionCable.server.broadcast "notification_team_#{params[:team_id]}", message: data['message']
    # ActionCable.server.broadcast "notification", message: data['message']
  end

end
