FactoryBot.define do
  factory :issue do
    number { Faker::Number.unique.number }
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }

    trait :with_events do
      events { [association(:event)] }
    end

    factory :issue_with_events, traits: [:with_events]
  end
end
