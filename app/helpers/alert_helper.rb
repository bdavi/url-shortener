# frozen_string_literal: true

# Helpers for alert partial
module AlertHelper
  ALERT_TYPE_ICON_MAP = {
    'error' => 'warning_triangle',
    'info' => 'info',
    'warning' => 'exclamation'
  }.freeze

  def alert_icon(type)
    unicode_icon(ALERT_TYPE_ICON_MAP[type])
  end
end
