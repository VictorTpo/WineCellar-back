# frozen_string_literal: true

FactoryBot.define do
  factory :wine_cellar do
    name { Faker::Lorem.word }
    association :account
  end
end
