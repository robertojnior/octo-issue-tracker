module V1
  class BaseAPI < Grape::API
    version :v1

    format :json

    helpers Helpers::HttpStatusHelper

    mount IssuesAPI
    mount EventsAPI
  end
end
