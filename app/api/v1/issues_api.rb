module V1
  class IssuesAPI < Grape::API
    get '/issues' do
      present Issue.all, with: Entities::IssueEntity
    end
  end
end
