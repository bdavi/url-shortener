# frozen_string_literal: true

# Models a shortened link
class Link < ApplicationRecord
  validates :url, presence: true, url: true

  validates :slug, presence: true, uniqueness: true

  scope :most_recent, Links::MostRecentQuery

  enum status: { pending: 0, approved: 1 }

  def short_url
    "#{ENV['DEFAULT_SHORT_LINK_HOST']}/#{slug}"
  end

  def relative_short_url
    "/#{slug}"
  end

  def self.slug_is_available?(slug)
    !exists?(slug: slug)
  end

  def self.slug_is_active?(slug)
    approved.exists?(slug: slug)
  end
end
