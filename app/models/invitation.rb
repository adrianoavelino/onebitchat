class Invitation < ApplicationRecord
  belongs_to :team
  enum status: [:pending, :accepted, :denied]
end
