class Message < ApplicationRecord
  belongs_to :messagable, polymorphic: true
  belongs_to :user
  validates_presence_of :body, :user

  after_create_commit :jobs

  private
  def jobs
    NotificationBroadcastJob.perform_later(self, user)
    MessageBroadcastJob.perform_later self
  end
end
