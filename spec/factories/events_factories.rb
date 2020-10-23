FactoryBot.define do
  factory :event do
    action { EventAction.list.sample }
    issued_on { Time.zone.now }
  end
end
