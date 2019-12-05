# frozen_string_literal: true

# Link related code
module Links
  # Finds available random slugs
  # In theory we could have a collision with an existing slug when
  # generating a new random slug. Retry until we hit the limit or
  # find one that is not in use.
  class AvailableSlugGenerator
    DEFAULT_COLLISION_RETRY_LIMIT = 50
    DEFAULT_SLUG_LENGTH = 5

    def initialize(length: nil, retries: nil)
      @length = length || DEFAULT_SLUG_LENGTH
      @retries = retries || DEFAULT_COLLISION_RETRY_LIMIT
    end

    def generate_slug
      retries.times do
        slug = _random_slug
        return slug if Link.slug_is_available?(slug)
      end

      raise CouldNotFindUniqueSlugError
    end

    private

    attr_reader :length, :retries

    def _random_slug
      # SecureRandom#urlsafe_base64 returns a string approx 4/3 the length
      # of passed n. Truncate to get exact desired length.
      SecureRandom.urlsafe_base64(length).first(length)
    end
  end

  class CouldNotFindUniqueSlugError < StandardError; end
end
