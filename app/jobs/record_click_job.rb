# frozen_string_literal: true

# Records a link click
class RecordClickJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(link, env_data, recorder: ClickRecorder.new)
    recorder.record_click(link, env_data)
  end
end
