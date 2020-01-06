# frozen_string_literal: true

# Controller for user dashboard routes
class DashboardController < SecureController
  def index
    @dashboard = DashboardPresenter.new
  end
end
