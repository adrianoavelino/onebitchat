FactoryBot.define do
  factory :invitation do
    email { FFaker::Internet.email }
    status {[:not_registered, :pending, :denied, :accepts].sample}
    team
  end
end
