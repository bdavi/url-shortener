# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    status { 'approved' }

    url { 'http://www.google.com' }

    sequence(:slug) do |n|
      "slug-#{n}"
    end

    Link.statuses.each do |status, _|
      trait status do
        status { status }
      end
    end
  end
end
