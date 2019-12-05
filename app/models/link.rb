# frozen_string_literal: true

# Core abstraction modeling a shortened link
class Link < ApplicationRecord
  validates :url, presence: true, url: true

  validates :slug, presence: true, uniqueness: true

  class << self
    def slug_is_available?(slug)
      find_by(slug: slug).nil?
    end
  end
end
