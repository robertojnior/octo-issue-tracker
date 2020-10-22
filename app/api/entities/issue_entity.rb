module Entities
  class IssueEntity < Grape::Entity
    expose :number
    expose :title
  end
end
