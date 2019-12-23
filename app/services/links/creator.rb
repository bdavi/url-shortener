# frozen_string_literal: true

# Link related code
module Links
  # Centralizes link creation logic
  class Creator
    delegate :generate_slug, to: :slug_generator

    def initialize(
      slug_generator: Links::AvailableSlugGenerator.new,
      safety_checker: LinkSafetyCheckJob
    )
      @slug_generator = slug_generator
      @safety_checker = safety_checker
    end

    def create(attrs)
      link = Link.new(attrs)
      link.slug ||= generate_slug

      if link.save # rubocop:disable Style/IfUnlessModifier
        safety_checker.perform_later(link)
      end

      link
    end

    private

    attr_reader :slug_generator, :safety_checker
  end
end
