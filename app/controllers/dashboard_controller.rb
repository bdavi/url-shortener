# frozen_string_literal: true

# Controller for user dashboard routes
class DashboardController < ApplicationController
  def show
    @dashboard = DashboardPresenter.new
  end
end
