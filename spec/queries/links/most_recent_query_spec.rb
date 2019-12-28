# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::MostRecentQuery, type: :query do
  describe '.call' do
    it 'returns the most recent links' do
      create(:link, created_at: 10.minutes.ago) # excluded older link

      most_recent = [
        create(:link, created_at: 2.minutes.ago),
        create(:link, created_at: 3.minutes.ago)
      ]

      query = described_class.call(limit: 2)

      expect(query).to be_a ActiveRecord::Relation
      expect(query.to_a).to eq most_recent
    end
  end
end
