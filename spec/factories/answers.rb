FactoryBot.define do
  factory :answer do
    content { [Faker::Number.between(from: 1, to: 5)] }
    association :question
    id {1}
    association :user
    association :form
    

  end
end