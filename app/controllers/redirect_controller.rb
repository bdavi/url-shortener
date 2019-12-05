# frozen_string_literal: true

# Controller for redirecting from slugs
class RedirectController < ApplicationController
  def redirect
    link = Link.find_by(slug: params[:slug])
    redirect_to link.url
  end
end
