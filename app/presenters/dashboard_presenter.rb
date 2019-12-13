# frozen_string_literal: true

# Presents data for a user dashboard
class DashboardPresenter
  def recent_links
    Link.most_recent
  end

  def new_link
    Link.new
  end
end
