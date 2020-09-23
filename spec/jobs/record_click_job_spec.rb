# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecordClickJob, type: :job do
  subject(:job) { described_class.new }

  it 'passes the needed data to the creator' do
    creator = instance_double('LinkClicks::Creator')
    link = instance_double('Link')
    request_data = 'abc123'

    expect(creator).to receive(:create).with(link: link, request_data: request_data)

    job.perform(link: link, request_data: request_data, creator: creator)
  end
end
