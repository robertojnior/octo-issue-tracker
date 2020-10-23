module Entities
  class EventEntity < Grape::Entity
    format_with(:iso_timestamp) { |date| date.iso8601 }

    expose :action

    with_options(format_with: :iso_timestamp) do
      expose :issued_on, as: :created_at
    end
  end
end
