# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :account__d, class: 'Account' do
    id { 12 }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    google_id { 012_012_012 }
  end
end
