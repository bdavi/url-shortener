# frozen_string_literal: true

# Application-wide helpers
module ApplicationHelper
  def page_title(title)
    provide(:title) { title }
  end
end
