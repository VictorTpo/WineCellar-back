# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :default_account, class: 'Account' do
    id { 12 }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    google_id { 12121212 }
  end
end
