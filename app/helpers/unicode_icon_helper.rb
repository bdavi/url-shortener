# frozen_string_literal: true

# Improve readability when using unicode chars for icons
module UnicodeIconHelper
  # Models unicode chars for use as icons
  class UnicodeIcon
    attr_reader :decimal_code, :char

    def initialize(decimal_code:, char:)
      # rubocop:disable Rails/HelperInstanceVariable
      @decimal_code = decimal_code
      @char = char
      # rubocop:enable Rails/HelperInstanceVariable
    end

    def to_html
      "&##{decimal_code};".html_safe # rubocop:disable Rails/OutputSafety
    end
  end

  # rubocop:disable HashAlignment
  UNICODE_ICONS = {
    close:            UnicodeIcon.new(decimal_code: '215',    char: '×'),
    warning_triangle: UnicodeIcon.new(decimal_code: '9888',   char: '⚠'),
    info:             UnicodeIcon.new(decimal_code: '119998', char: '𝒾'),
    exclamation:      UnicodeIcon.new(decimal_code: '33',     char: '!'),
    check:            UnicodeIcon.new(decimal_code: '10003',  char: '✓')
  }.freeze
  # rubocop:enable HashAlignment

  def unicode_icon(name)
    UNICODE_ICONS[name.to_sym].to_html
  end
end
