# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "email#{n}@somedomain.com"
    end

    password { 'Str0ngP@ssw0rdGoes<Here>!!!!!!!!!!!' }
  end
end
