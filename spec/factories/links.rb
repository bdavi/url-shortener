FactoryBot.define do
  factory :link do
    url { 'http://www.google.com' }

    sequence(:slug) do |n|
      "slug-#{n}"
    end
  end
end
