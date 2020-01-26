# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  # rubocop:disable RSpec/ExampleLength
  it :aggregate_failures do
    is_expected.to have_a_valid_default_factory

    is_expected.to have_db_column :slug
    is_expected.to have_db_column :status
    is_expected.to have_db_column :url

    is_expected.to validate_presence_of :slug
    is_expected.to validate_presence_of :url
    is_expected.to validate_the_uniqueness_of :slug
    is_expected.to validate_url_format_of :url

    is_expected.to have_many(:link_clicks).dependent(:restrict_with_error)

    is_expected.to default(:status).to('pending')

    is_expected.to delegate_scope(:most_recent).to(Links::MostRecentQuery)

    is_expected.to have_enum(:status).with_values('pending', 'approved', 'failed_safety_check')
  end
  # rubocop:enable RSpec/ExampleLength

  describe '.slug_is_available?' do
    context 'when a link has that slug' do
      it 'returns false' do
        create(:link, slug: 'abc123')

        expect(described_class.slug_is_available?('abc123')).to be false
      end
    end

    context 'when no link has that slug' do
      it 'returns true' do
        slug = 'abc123'

        expect(described_class.slug_is_available?(slug)).to be true
      end
    end
  end

  describe '#short_url' do
    it 'joins the host and slug with a forward slash' do
      ENV['APPLICATION_HOST'] = 'http://www.test.com'
      link = build_stubbed(:link, slug: 'abc')

      expect(link.short_url).to eq 'http://www.test.com/abc'
    end
  end

  describe '#relative_short_url' do
    it 'concatenates a forward slash and the slug' do
      link = build_stubbed(:link, slug: 'abc')

      expect(link.relative_short_url).to eq '/abc'
    end
  end

  describe '.slug_is_active?' do
    context 'when the slug has an approved link' do
      it 'returns true' do
        link = create(:link, :approved)

        expect(described_class.slug_is_active?(link.slug)).to be true
      end
    end

    %i[pending failed_safety_check].each do |status|
      context "when the slug has a #{status} link" do
        it 'returns false' do
          link = create(:link, status)

          expect(described_class.slug_is_active?(link.slug)).to be false
        end
      end
    end

    context 'when the slug does not have a link' do
      it 'returns false' do
        expect(described_class.slug_is_active?('not-a-slug')).to be false
      end
    end
  end
end
