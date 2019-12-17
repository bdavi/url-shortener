# frozen_string_literal: true

FactoryBot.define do
  factory :external_http_request_log do
    kind { 'SomeClass#method' }

    meta do
      { some: 'extra info here' }
    end

    response_body do
      { the: 'response' }.to_json
    end

    response_code { 200 }
  end
end
