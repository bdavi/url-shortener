# frozen_string_literal: true

# Models user dashboard
class Dashboard
  LINKS_TO_DISPLAY = 5

  def recent_links
    Link.order(created_at: :desc).limit(LINKS_TO_DISPLAY)
  end

  def new_link
    Link.new
  end
end
