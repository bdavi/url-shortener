# frozen_string_literal: true

# View helpers for the flash
module FlashHelper
  FLASH_TYPE_ICON_MAP = {
    'error' => 'warning_triangle',
    'notice' => 'info',
    'alert' => 'exclamation',
    'success' => 'check'
  }.freeze

  def displayable_flash_types
    %w[error notice alert success].freeze
  end

  def flash_icon(type)
    unicode_icon(FLASH_TYPE_ICON_MAP[type])
  end
end
