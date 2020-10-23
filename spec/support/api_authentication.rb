module APIAuthentication
  def mock_authentication
    let(:username) { Faker::Internet.username }
    let(:password) { Faker::Internet.password }
    let(:credentials) { Base64.strict_encode64("#{username}:#{password}") }

    before do
      allow(Rails.application.credentials).to receive(:default_username).and_return(username)

      allow(Rails.application.credentials).to receive(:default_password).and_return(password)

      Grape::Endpoint.before_each do |endpoint|
        allow(endpoint).to receive(:headers).and_return({ 'Authorization' => "Basic #{credentials}" })
      end
    end

    after { Grape::Endpoint.before_each nil }
  end
end

RSpec.configure do |config|
  config.extend APIAuthentication, type: :request
end
