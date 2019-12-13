# frozen_string_literal: true

# Checks that a slug is valid for routing purposes
class ActiveSlugConstraint
  def matches?(request)
    Link.slug_is_active?(request.params[:slug])
  end
end
