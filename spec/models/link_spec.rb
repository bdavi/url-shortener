# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  it 'has a valid factory' do
    expect(build_stubbed(:link)).to be_valid
  end

  it 'has the correct attributes, validations and associations', :aggregate_failures do
    is_expected.to have_attribute :slug
    is_expected.to have_attribute :status
    is_expected.to have_attribute :url

    is_expected.to validate_presence_of :slug
    is_expected.to validate_presence_of :url
    is_expected.to validate_url_format_of :url

    is_expected.to have_many(:link_clicks).dependent(:restrict_with_error)
  end

  it 'has the expected statuses' do
    expected = { 'pending' => 0, 'approved' => 1, 'failed_safety_check' => 2 }
    expect(described_class.statuses).to eq expected
  end

  it 'defaults status to `pending`' do
    expect(described_class.new).to be_pending
  end

  it 'validates uniqueness of #slug' do
    link = create(:link)
    duplicate = build_stubbed(:link, slug: link.slug)

    duplicate.valid?
    expect(duplicate.errors[:slug]).to include 'has already been taken'
  end

  describe '.slug_is_available?' do
    context 'when a link has that slug' do
      it 'returns false' do
        slug = 'abc'
        create(:link, slug: slug)
        expect(described_class.slug_is_available?(slug)).to be false
      end
    end

    context 'when no link has that slug' do
      it 'returns true' do
        slug = 'abc'
        expect(described_class.slug_is_available?(slug)).to be true
      end
    end
  end

  describe '#short_url' do
    it 'joins the host and slug with a forward slash' do
      ENV['DEFAULT_SHORT_LINK_HOST'] = 'http://www.test.com'
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

  describe '.scopes' do
    subject { described_class }

    it { is_expected.to delegate_scope(:most_recent).to(Links::MostRecentQuery) }
  end
end
