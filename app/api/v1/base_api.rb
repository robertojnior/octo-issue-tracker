module V1
  class BaseAPI < Grape::API
    version :v1

    format :json

    helpers Helpers::BasicAuthenticationHelper

    before { authenticate! unless public? }

    mount IssuesAPI
    mount EventsAPI
  end
end
