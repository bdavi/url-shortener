# frozen_string_literal: true

# Abstract controller which all other controllers derive from
class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(_)
    dashboard_index_path
  end
end
