# frozen_string_literal: true

# Abstract Application Record
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
