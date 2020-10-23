module V1
  module Helpers
    module BasicAuthenticationHelper
      def authenticate!
        error!({}, :unauthorized) unless authorized?
      end

      def public?
        route.settings.dig(:auth, :disabled)
      end

      def authorized?
        return false if headers['Authorization'].blank?

        _, credentials = headers['Authorization'].split(' ')

        username, password = Base64.decode64(credentials).split(':')

        default_username = Rails.application.credentials.default_username
        default_password = Rails.application.credentials.default_password

        ActiveSupport::SecurityUtils.secure_compare(username, default_username) &&
          ActiveSupport::SecurityUtils.secure_compare(password, default_password)
      end
    end
  end
end
