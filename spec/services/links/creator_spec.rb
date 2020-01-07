# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::Creator, type: :service do
  subject(:creator) { described_class.new }

  describe '#create' do
    it 'returns a link with the passed attribues' do
      url = 'http://www.google.com'

      link = creator.create(url: url)

      expect(link).to be_a Link
      expect(link.url).to eq url
    end

    it 'persists the link' do
      url = 'http://www.google.com'

      link = creator.create(url: url)

      expect(link).to be_persisted
    end

    it 'enqueues a LinkSafetyCheckJob' do
      ActiveJob::Base.queue_adapter = :test
      url = 'http://www.google.com'

      expect do
        creator.create(url: url)
      end.to have_enqueued_job(LinkSafetyCheckJob)
    end

    context 'when the attrs are invalid' do
      it 'does not enqueue a LinkSafetyCheckJob' do
        ActiveJob::Base.queue_adapter = :test

        expect do
          creator.create({})
        end.not_to have_enqueued_job(LinkSafetyCheckJob)
      end

      it 'returns a link that is not persisted' do
        link = creator.create({})

        expect(link).to be_a Link
        expect(link).not_to be_persisted
      end
    end

    context 'when no slug is passed in the attrs' do
      it 'generates a slug and sets the attribute' do
        slug = 'abc'
        generator = instance_double('AvailableSlugGenerator', generate_slug: slug)
        creator = described_class.new(slug_generator: generator)
        url = 'http://www.google.com'

        link = creator.create(url: url)

        expect(link.slug).to eq slug
      end
    end

    context 'when a slug is passed in the attrs' do
      it 'sets that value on the link' do
        slug = 'abc'
        url = 'http://www.google.com'

        link = creator.create(url: url, slug: slug)

        expect(link.slug).to eq slug
      end
    end
  end
end
