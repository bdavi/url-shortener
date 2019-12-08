# frozen_string_literal: true

# View helpers for the flash
module FlashHelper
  DISPLAYABLE_FLASH_TYPES = %w[notice alert warning].freeze

  FLASH_TO_ALERT_TYPE_MAP = {
    'notice' => 'info',
    'alert' => 'error',
    'warning' => 'warning'
  }.freeze

  def flash_is_displayable?(flash_type)
    DISPLAYABLE_FLASH_TYPES.include?(flash_type)
  end

  def alert_type(flash_type)
    FLASH_TO_ALERT_TYPE_MAP[flash_type]
  end
end
