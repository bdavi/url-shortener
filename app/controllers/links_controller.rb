# frozen_string_literal: true

# Controller for Link related routes
class LinksController < SecureController
  def create
    link = Links::Creator.new.create(link_params)

    if link.persisted?
      redirect_to dashboard_index_path, flash: { success: 'Link was successfully created.' }
    else
      redirect_to dashboard_index_path, flash: { error: 'There was an error creating the link' }
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
