# frozen_string_literal: true

FactoryBot.define do
  factory :link_click do
    association :link

    host { 'www.thedomain.com' }

    user_agent do
      'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:71.0) Gecko/20100101 Firefox/71.0'
    end

    referer { 'some.otherdomain.com/page' }

    anonymized_ip { '73.243.86.X' }
  end
end
