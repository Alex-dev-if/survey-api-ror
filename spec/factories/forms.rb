FactoryBot.define do
  factory :form do
    title {Faker::Lorem.sentence }
    respond_until {Faker::Time.between(from: DateTime.now, to: 30.days.from_now)}
    opened {[true, false].sample}
    association :user
    id { 1 }


  end
end