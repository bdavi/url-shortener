# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecordClickJob, type: :job do
  subject(:job) { described_class.new }

  it 'passes the link and env_data to recorder' do
    recorder = instance_double('ClickRecorder')
    link = instance_double('Link')
    env_data = {}

    expect(recorder).to receive(:record_click).with(link, env_data)

    job.perform(link, env_data, recorder: recorder)
  end
end
