# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::Builder do
  describe '#build' do
    it 'returns a link with the passed attribues' do
      url = 'http://www.google.com'
      attrs = { url: url }
      link = described_class.new.build(attrs)

      expect(link).to be_a Link
      expect(link.url).to eq url
    end

    context 'when no slug is passed in the attrs' do
      it 'generates a slug and sets the attribute' do
        slug = 'abc'
        generator = double(generate_slug: slug)
        builder = described_class.new(slug_generator: generator)
        link = builder.build({})

        expect(link.slug).to eq slug
      end
    end

    context 'when a slug is passed in the attrs' do
      it 'sets that value on the link' do
        slug = 'abc'
        builder = described_class.new
        link = builder.build(slug: slug)

        expect(link.slug).to eq slug
      end
    end
  end
end
