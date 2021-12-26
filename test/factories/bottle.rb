# frozen_string_literal: true

FactoryBot.define do
  factory :bottle do
    name { Faker::Lorem.word }
    association :wine_cellar
  end
end
