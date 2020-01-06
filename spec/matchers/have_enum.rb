# frozen_string_literal: true

require 'rspec/rails'

# Module for custom RSpec matchers
module Matchers
  # Tests that an enum exists with the expected values.
  #
  # Example usage:
  #   it { is_expected.to have_enum(:enum_name).with_values(:val, :val2) }
  #
  def have_enum(attr)
    HaveEnumMatcher.new(attr)
  end

  # Matcher to determine if a model has an enum with the expected values
  class HaveEnumMatcher
    attr_reader :enum_name, :expected_values, :_failure_messages, :subject

    def initialize(enum_name)
      @enum_name = enum_name
      @_failure_messages = []
    end

    def matches?(subject)
      @subject = subject

      if _valid?
        _run_responds_to_match
        _run_values_match
      end

      _failure_messages.empty?
    end

    def does_not_match?(subject)
      !matches?(subject)
    end

    def with_values(*expected_values)
      @expected_values = expected_values
      self
    end

    def description
      "have an enum #{enum_name} with values: #{expected_values}"
    end

    def failure_message
      _failure_messages.join("\n")
    end

    def failure_message_when_negated
      "#{_described_class} has an enum #{enum_name}"
    end

    private

    def _valid?
      if expected_values.any?
        true
      else
        _failure_messages << 'Must supply expected values with `#with_values`'
        false
      end
    end

    def _run_responds_to_match
      return if _responds_to_enum_method?

      _failure_messages << "Expected #{_described_class} to respond to #{_plural_enum_name}"
    end

    def _run_values_match
      return if !_responds_to_enum_method? || _actual_values == expected_values

      _failure_messages << <<-MSG.strip_heredoc
        Expected #{_described_class} to have these #{_plural_enum_name}:
          #{expected_values}
        Instead got:
          #{_actual_values}
      MSG
    end

    def _actual_values
      _described_class.try(_plural_enum_name)&.keys
    end

    def _described_class
      subject.class == Class ? subject : subject.class
    end

    def _plural_enum_name
      enum_name.to_s.pluralize
    end

    def _responds_to_enum_method?
      _described_class.respond_to?(_plural_enum_name)
    end
  end
end
