module Entities
  class IssueEntity < Grape::Entity
    expose :number
    expose :title
    expose :events, using: 'Entities::EventEntity', if: { type: :full }
  end
end
