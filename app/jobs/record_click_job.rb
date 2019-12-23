# frozen_string_literal: true

# Records a link click
class RecordClickJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(link:, env_data:, clicked_at:, recorder: ClickRecorder.new)
    recorder.record_click(
      link: link,
      env_data: env_data,
      clicked_at: clicked_at
    )
  end
end
