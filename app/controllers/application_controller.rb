# frozen_string_literal: true

# Abstract controller which all other controllers derive from
class ApplicationController < ActionController::Base
  default_form_builder ApplicationFormBuilder
end
