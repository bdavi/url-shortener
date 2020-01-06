# frozen_string_literal: true

require 'rspec/rails'

# Module for custom RSpec matchers
module Matchers
  # Tests that an ActiveRecord scope is being delegated to a query class
  #
  # Example usage:
  #   it { is_expected.to delegate_scope(:scope_name).to(QueryClass) }
  #
  def delegate_scope(attr)
    DelegateScopeMatcher.new(attr)
  end

  # Matcher to determine if a model delegates a scope to a query class
  class DelegateScopeMatcher
    include RSpec::Mocks::ExampleMethods

    attr_reader :scope_name, :query_class

    def initialize(scope_name)
      @scope_name = scope_name
    end

    def matches?(subject)
      _scope_calls_query_class?(subject)
    end

    def does_not_match?(subject)
      !matches?(subject)
    end

    def to(query_class)
      @query_class = query_class
      self
    end

    def description
      "delegate scope .#{scope_name} to #{query_class.name}"
    end

    def failure_message
      return _missing_query_msg unless query_class

      "#{query_class.name} did not receive `.call`"
    end

    def failure_message_when_negated
      return _missing_query_msg unless query_class

      "#{query_class.name} received `.call`"
    end

    private

    def _described_class(subject)
      subject.class == Class ? subject : subject.class
    end

    def _missing_query_msg
      'Must supply query class with `#to` method'
    end

    def _scope_calls_query_class?(subject)
      return false unless query_class

      allow(query_class).to receive(:call).and_return(:scope)
      _described_class(subject).public_send(scope_name) == :scope
    end
  end
end
