class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, user)
    m = message.messagable
    chat_name = "notification_team_#{m.team.id}"
    slug = nil
    type = nil

    if (m.class == Channel)
      slug = m.slug
      type = 'channels'
    else
      user_one = User.find(m.user_one_id).name
      user_two = User.find(m.user_two_id).name
      owner = (user.name == user_one)? user_one : user_two
      member = (owner != user_one)? user_two : user_one
      slug = []
      slug.push(owner)
      slug.push(member)
      type = 'talks'
    end

    ActionCable.server.broadcast(chat_name, {
                                          slug: slug,
                                          type: type
                                        })
  end
end
