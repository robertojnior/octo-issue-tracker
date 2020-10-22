module OctoIssueTracker
  module V1
    class IssuesAPI < Grape::API
      resources :issues do
        get do
          issues = Issue.all

          present issues, with: Entities::IssueEntity
        end
      end
    end
  end
end
