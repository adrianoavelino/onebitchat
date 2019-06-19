module ApplicationHelper
  def is_channel_updated(chat, user)
    notification = Notification.where(user_id: user.id, notificable_id: chat.id, notificable_type: chat.class.to_s).last
    message = Message.where(messagable_id: chat.id, messagable_type: chat.class.to_s).last
    return true if notification.nil? || message.nil?
    if notification.updated_at >= message.updated_at
      true
    end
  end

  def is_talk_updated(user, current_user, team)
    talk = Talk.where(user_one_id: user.id, user_two_id: current_user.id, team_id: team.id).or(Talk.where(user_one_id: current_user.id, user_two_id: user.id, team_id: team.id)).last
    return true if talk.nil?
    notification = Notification.where(user_id: current_user.id, notificable_id: talk.id, notificable_type: "Talk").last
    message = Message.where(messagable_id: talk.id, messagable_type: "Talk").last
    return true if notification.nil? || message.nil?
    if notification.updated_at >= message.updated_at
      true
    end
  end
end
