class NotificationsController < ApplicationController
  def update_or_create

    notificable = get_notificable()
    notification = Notification.where(user_id: current_user.id, notificable_id: notificable.id, notificable_type: notificable.class.to_s)
    notification.update_or_create(updated_at: Time.now)
    render json: { status: :created, notification: notification }
  end

  private
  def notification_params
    params.require(:notification).permit(:id, :user_id, :message_id)
  end

  def get_notificable
    member_id = params[:notification][:member_id]
    message_id = params[:notification][:message_id]
    team_id = params[:notification][:team_id]
    if !member_id.nil?
      notificable = Talk.where(user_one_id: member_id, user_two_id: current_user.id, team_id: team_id).or(Talk.where(user_one_id: current_user.id, user_two_id: member_id, team_id: team_id)).last
    elsif message_id.nil?
      notificable = Channel.find(params[:notification][:channel_id])
    else
      message = Message.find(message_id)
      notificable = message.messagable
    end
  end
end
