# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActiveSlugConstraint, type: :helper do
  describe '#matches?' do
    subject { described_class.new }

    let(:slug) { 'abc' }
    let(:params) { { slug: slug } }
    let(:request) { double(params: params) }

    context 'when the slug is active' do
      it 'return true' do
        allow(Link).to receive(:slug_is_active?).with(slug).and_return(true)
        expect(subject.matches?(request)).to be true
      end
    end

    context 'when the slug is not active' do
      it 'returns false' do
        allow(Link).to receive(:slug_is_active?).with(slug).and_return(false)
        expect(subject.matches?(request)).to be false
      end
    end
  end
end
