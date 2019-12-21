# frozen_string_literal: true

# Models a click on a shortened Link
class LinkClick < ApplicationRecord
  validates :host, presence: true

  validates :user_agent, presence: true

  validates :anonymized_ip, presence: true

  belongs_to :link
end
