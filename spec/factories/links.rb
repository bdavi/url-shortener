# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    status { 'approved' }

    url { 'http://www.google.com' }

    sequence(:slug) do |n|
      "slug-#{n}"
    end

    trait :pending do
      status { 'pending' }
    end

    trait :approved do
      status { 'approved' }
    end
  end
end
