FactoryBot.define do
  factory :question do
    id { 1 }
    title {Faker::Lorem.question }
    required {[true, false].sample}
    options { Faker::Lorem.words(number: 4) }
    order { 1 }
    question_type { "radio" }
    association :form

  end
end