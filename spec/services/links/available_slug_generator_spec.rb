# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::AvailableSlugGenerator do
  describe '#generate_slug' do
    it 'returns a random value of the correct length' do
      length = 3
      creator = described_class.new(length: length)
      slug = creator.generate_slug

      expect(slug.length).to eq length
    end

    it 'raises error when collision retries limit is reached' do
      limit = 2
      creator = described_class.new(retries: limit)
      allow(Link).to receive(:slug_is_available?) { false }

      expect do
        creator.generate_slug
      end.to raise_error(Links::CouldNotFindUniqueSlugError)
    end
  end
end
