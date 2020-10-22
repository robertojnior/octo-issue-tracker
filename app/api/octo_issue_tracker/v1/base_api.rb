module OctoIssueTracker
  module V1
    class BaseAPI < Grape::API
      version :v1, using: :path

      format :json
    end
  end
end
