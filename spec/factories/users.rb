FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    password { SecureRandom.hex }
    role { "adm" }
    id { 1 }

  end
end