# frozen_string_literal: true

# Controller for Link related routes
class LinksController < ApplicationController
  def create
    link = Links::Builder.new.build(link_params)

    if link.save
      redirect_to root_path, flash: { success: 'Link was successfully created.' }
    else
      redirect_to root_path, flash: { error: 'There was an error creating the link' }
    end
  end

  def redirect
    link = Link.find_by(slug: params[:slug])
    redirect_to link.url
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
