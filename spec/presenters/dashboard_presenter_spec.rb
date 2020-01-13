# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardPresenter, type: :presenter do
  subject(:dashboard_presenter) { described_class.new }

  describe '#recent_links' do
    it 'returns the most recent links' do
      recent_links = [instance_double('Link')]
      allow(Link).to receive(:most_recent).and_return(recent_links)

      expect(dashboard_presenter.recent_links).to eq recent_links
    end
  end

  describe '#new_link' do
    it 'returns a new link' do
      new_link = instance_double('Link')
      allow(Link).to receive(:new).and_return(new_link)

      expect(dashboard_presenter.new_link).to eq new_link
    end
  end
end
