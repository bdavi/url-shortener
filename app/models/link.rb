# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  status     :integer          default("pending")
#  url        :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_links_on_slug  (slug) UNIQUE
#

# Models a shortened link
class Link < ApplicationRecord
  validates :url, presence: true, url: true

  validates :slug, presence: true, uniqueness: true

  scope :most_recent, Links::MostRecentQuery

  enum status: { pending: 0, approved: 1, failed_safety_check: 2 }

  has_many :link_clicks, dependent: :restrict_with_error

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
