# frozen_string_literal: true

# Load custom matchers
Dir[Rails.root.join('spec/matchers/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Matchers
end

###############################################################################
# Matchers
###############################################################################

# Tests that the default factory is valid
#
# Example Usage:
#   it { is_expected.to have_a_valid_default_factory }
#
RSpec::Matchers.define :have_a_valid_default_factory do
  match do
    build_stubbed(default_factory).valid?
  end
end

# Tests there is a uniqueness validation on the passed attribute.
#
# For our purposes this is easier to use than the standard Shoulda Matchers
# implementation, but it has several major flaws:
# - it ignores the subject
# - it assumes the default factory exists and is valid
# - it doesn't support options like a custom message, scope or case insensitivity
#
# Example Usage:
#   it { is_expected.to validate_the_uniqueness_of :slug }
#
RSpec::Matchers.define :validate_the_uniqueness_of do |attr|
  match do
    original = create(default_factory)
    duplicate = build_stubbed(default_factory, attr => original.send(attr))

    duplicate.valid?
    duplicate.errors[attr].include? 'has already been taken'
  end
end

###############################################################################
# Helpers
###############################################################################
# The "default factory" is the one which corresponds to the name of the class
def default_factory
  described_class.name.underscore
end
