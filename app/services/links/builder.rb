# frozen_string_literal: true

# Link related code
module Links
  # Centralizes link building logic
  class Builder
    delegate :generate_slug, to: :slug_generator

    def initialize(slug_generator: Links::AvailableSlugGenerator.new)
      @slug_generator = slug_generator
    end

    def build(attrs)
      link = Link.new(attrs)
      link.slug ||= generate_slug
      link
    end

    private

    attr_reader :slug_generator
  end
end
