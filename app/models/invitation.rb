class Invitation < ApplicationRecord
  belongs_to :team
  enum status: [:not_registered, :pending, :denied, :accepts]
end
