class NotificationsController < ApplicationController
  def update_or_create
    message = Message.find(params[:notification][:message_id])
    notificable = message.messagable
    user = User.find(params[:notification][:current_user_id])
    notification = Notification.where(user_id: user.id, notificable_id: notificable.id, notificable_type: notificable.class.to_s)
    notification.update_or_create(updated_at: Time.now)
    render json: { status: :created, notification: notification }
  end

  private
  def notification_params
    params.require(:notification).permit(:id, :user_id, :message_id)
  end
end
