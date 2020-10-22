require 'rails_helper'

RSpec.describe OctoIssueTracker::V1::IssuesAPI, type: :request do
  describe 'GET /v1/issues' do
    let(:issue) { build(:issue) }

    before do
      allow(Issue).to receive(:all).and_return([issue])
    end

    it 'is expected to have http status OK' do
      get '/v1/issues'

      expect(response).to have_http_status(:ok)
    end

    it 'is expected to renders an array issue entities as JSON' do
      get '/v1/issues'

      expected_response = [Entities::IssueEntity.new(issue)].to_json

      expect(response.body).to eq(expected_response)
    end
  end
end
