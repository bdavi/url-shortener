# frozen_string_literal: true

# Link related code
module Links
  # Queries for most recent Links
  class MostRecentQuery < ApplicationQuery
    DEFAULT_LIMIT = 5

    def call(relation = Link.all, limit: DEFAULT_LIMIT)
      relation.order(created_at: :desc).limit(limit)
    end
  end
end
