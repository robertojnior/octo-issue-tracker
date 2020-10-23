module V1
  module Helpers
    module HttpStatusHelper
      def created
        201
      end

      def not_found
        404
      end

      def unprocessable_entity
        422
      end
    end
  end
end
