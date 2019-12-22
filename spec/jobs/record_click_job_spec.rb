# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecordClickJob, type: :job do
  subject(:job) { described_class.new }

  it 'passes the link, env_data and clicked_at to recorder' do
    recorder = instance_double('ClickRecorder')
    link = instance_double('Link')
    env_data = {}
    clicked_at = DateTime.now

    expect(recorder).to receive(:record_click)
      .with(link: link, env_data: env_data, clicked_at: clicked_at)

    job.perform(link: link, env_data: env_data, clicked_at: clicked_at, recorder: recorder)
  end
end
