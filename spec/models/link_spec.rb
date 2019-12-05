# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  it 'has a valid factory' do
    expect(build(:link)).to be_valid
  end

  it { is_expected.to have_attribute :url }

  it { is_expected.to have_attribute :slug }

  it { is_expected.to validate_presence_of :url }

  it { is_expected.to validate_presence_of :slug }

  it 'validates uniqueness of #slug' do
    link = create(:link)
    duplicate = build(:link, slug: link.slug)

    duplicate.valid?
    expect(duplicate.errors[:slug]).to include 'has already been taken'
  end

  it 'validates #url is a valid url' do
    link = build(:link, url: 'invalid-url')
    link.valid?
    expect(link.errors[:url]).to include 'is an invalid URL'
  end

  it 'validates http urls' do
    link = build(:link, url: 'http://www.google.com/test?some=stuff')
    expect(link).to be_valid
  end

  it 'validates https urls' do
    link = build(:link, url: 'https://www.google.com/test?some=stuff')
    expect(link).to be_valid
  end

  describe '#slug_is_available?' do
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
end
