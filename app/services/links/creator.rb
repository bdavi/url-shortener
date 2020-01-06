# frozen_string_literal: true

# Link related code
module Links
  # Centralizes link creation logic
  class Creator
    attr_reader :slug_generator, :safety_checker

    delegate :generate_slug, to: :slug_generator

    def initialize(
      slug_generator: Links::AvailableSlugGenerator.new,
      safety_checker: LinkSafetyCheckJob
    )
      @slug_generator = slug_generator
      @safety_checker = safety_checker
    end

    def create(attrs)
      Link.new(attrs).tap do |link|
        link.slug ||= generate_slug
        safety_checker.perform_later(link) if link.save
      end
    end
  end
end
