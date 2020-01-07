# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::AvailableSlugGenerator, type: :service do
  describe '#generate_slug' do
    it 'returns a random value of the correct length' do
      length = 3
      generator = described_class.new(length: length)

      slug = generator.generate_slug

      expect(slug.length).to eq length
    end

    it 'raises error when collision retries limit is reached' do
      limit = 3
      generator = described_class.new(retries: limit)
      allow(Link).to receive(:slug_is_available?).and_return(false)

      expect do
        generator.generate_slug
      end.to raise_error(Links::CouldNotFindUniqueSlugError)
    end
  end
end
