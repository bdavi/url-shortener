# frozen_string_literal: true

# Application-wide helpers
module ApplicationHelper
  def default_title
    'URL Shortener'
  end

  def page_title(title)
    provide(:title) { title }
  end
end
