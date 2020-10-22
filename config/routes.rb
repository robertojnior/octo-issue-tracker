Rails.application.routes.draw do
  mount OctoIssueTracker::BaseAPI => '/'
end
