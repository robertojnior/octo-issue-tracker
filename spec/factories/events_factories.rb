FactoryBot.define do
  factory :event do
    issue { nil }
    action { EventAction.list.sample }
    issued_on { Time.zone.now }
  end
end
