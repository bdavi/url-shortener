# frozen_string_literal: true

# Abstract. Derive from this when needing authentication.
class SecureController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_user!
end
