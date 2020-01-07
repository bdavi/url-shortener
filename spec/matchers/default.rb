# frozen_string_literal: true

require 'rspec/rails'

# Module for custom RSpec matchers
module Matchers
  # Tests that a record has a default value
  #
  # Example usage:
  #   it { is_expected.to default(:attribute).to(default_value) }
  #
  def default(attr)
    DefaultValueMatcher.new(attr)
  end

  # Matcher to determine if a model defaults an attribute to a specific value
  class DefaultValueMatcher
    attr_reader :attribute, :default_value, :subject

    def initialize(attribute)
      @attribute = attribute
    end

    def matches?(subject)
      @subject = subject

      default_value && _actual_value == default_value
    end

    def does_not_match?(subject)
      !matches?(subject)
    end

    def to(default_value)
      @default_value = default_value
      self
    end

    def description
      "default ##{attribute} to #{default_value}"
    end

    def failure_message
      _missing_default_value_message ||
        "expected #{attribute} to equal #{default_value} but was #{_actual_value}"
    end

    def failure_message_when_negated
      _missing_default_value_message || "expected #{attribute} to not equal #{default_value}"
    end

    private

    # Returns a new instance of the described class
    def _new_instance
      klass = subject.class == Class ? subject : subject.class
      klass.new
    end

    def _actual_value
      _new_instance.public_send(attribute)
    end

    def _missing_default_value_message
      return nil if default_value

      'Must supply expected default value with `#to` method'
    end
  end
end
