# frozen_string_literal: true

# Customize default form builder
class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  DEFAULT_FORM_DATA = { remote: false }.freeze

  def initialize(_, _, _, options)
    _assign_default_data(options)

    super
  end

  private

  # WARNING: Mutates parameters
  def _assign_default_data(options)
    data = options[:data] || {}
    options[:data] = DEFAULT_FORM_DATA.merge(data)
  end
end
