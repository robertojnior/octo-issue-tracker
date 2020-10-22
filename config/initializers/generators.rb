Rails.application.config.generators do |generator|
  generator.test_framework :rspec

  generator.factory_bot suffix: 'factories'

  generator.fixture_replacement :factory_bot, dir: 'spec/factories'
end
