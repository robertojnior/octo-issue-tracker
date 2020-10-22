module V1
  class BaseAPI < Grape::API
    version :v1

    format :json

    mount IssuesAPI
  end
end
