# frozen_string_literal: true

# == Schema Information
#
# Table name: link_clicks
#
#  id                 :bigint           not null, primary key
#  anonymized_ip      :string           not null
#  city               :string
#  clicked_at         :datetime         not null
#  country            :string
#  device_brand       :string
#  device_family      :string
#  device_model       :string
#  host               :string           not null
#  isp                :string
#  latitude           :decimal(, )
#  longitude          :decimal(, )
#  os_family          :string
#  os_version         :string
#  referer            :text
#  region             :string
#  timezone           :string
#  timezone_name      :string
#  user_agent         :text             not null
#  user_agent_family  :string
#  user_agent_version :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  link_id            :bigint           not null
#
# Indexes
#
#  index_link_clicks_on_link_id  (link_id)
#
# Foreign Keys
#
#  fk_rails_a45007ca54  (link_id => links.id)
#

# Models a click on a shortened Link
class LinkClick < ApplicationRecord
  validates :host, presence: true

  validates :user_agent, presence: true

  validates :anonymized_ip, presence: true

  validates :clicked_at, presence: true

  belongs_to :link
end
