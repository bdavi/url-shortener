# frozen_string_literal: true

# Controller for user dashboard routes
class DashboardController < ApplicationController
  def show
    @dashboard = Dashboard.new
  end

  def create_link
    @link = Links::Builder.new.build(link_params)

    if @link.save
      redirect_to root_path, notice: 'Link was successfully created.'
    else
      redirect_to root_path, notice: 'There was an error creating the link'
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
