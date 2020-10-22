FactoryBot.define do
  factory :issue do
    number { Faker::Number.unique.number }
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end
