# frozen_string_literal: true

# Abstract Job
class ApplicationJob < ActiveJob::Base
  include Bullet::ActiveJob if Rails.env.development?
end
