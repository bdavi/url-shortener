# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecordClickJob, type: :job do
  subject(:job) { described_class.new }

  # rubocop:disable RSpec/ExampleLength
  it 'passes the needed data to the creator' do
    creator = instance_double('LinkClicks::Creator')
    link = instance_double('Link')
    env_data = {}
    clicked_at = DateTime.now
    remote_ip = '50.246.198.147'

    expect(creator).to receive(:create)
      .with(link: link, env_data: env_data, clicked_at: clicked_at, remote_ip: remote_ip)

    job.perform(
      link: link,
      env_data: env_data,
      clicked_at: clicked_at,
      creator: creator,
      remote_ip: remote_ip
    )
  end
  # rubocop:enable RSpec/ExampleLength
end
