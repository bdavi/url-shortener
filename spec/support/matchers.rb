# frozen_string_literal: true

# Load custom matchers
Dir[Rails.root.join('spec/matchers/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Matchers
end
