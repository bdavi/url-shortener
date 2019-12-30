# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationQuery, type: :query do
  describe 'class methods' do
    subject { described_class }

    it { is_expected.to delegate_method(:call).to(:new) }
  end

  describe 'instance methods' do
    subject(:query) { described_class.new }

    describe '#call' do
      it 'raises a NotImplementedError' do
        expect do
          query.call
        end.to raise_error(NotImplementedError)
      end
    end
  end
end
