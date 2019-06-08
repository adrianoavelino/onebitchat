class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_team_#{params[:team_id]}"
  end

  def receive(data)
    @message = Message.new(body: data["message"], user: current_user)
    @message
  end

end
