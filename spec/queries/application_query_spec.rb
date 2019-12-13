# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationQuery do
  context 'class methods' do
    subject { described_class }

    it { is_expected.to delegate_method(:call).to(:new) }
  end

  context 'instance methods' do
    subject { described_class.new }

    describe '#call' do
      it 'raises a NotImplementedError' do
        expect do
          subject.call
        end.to raise_error(NotImplementedError)
      end
    end
  end
end
