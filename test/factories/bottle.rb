# frozen_string_literal: true

FactoryBot.define do
  factory :bottle do
    name { Faker::Lorem.word }
    association :wine_cellar
  end

  factory :bottle__d, class: 'Bottle' do
    name { Faker::Lorem.word }
    association :wine_cellar, factory: :wine_cellar__d
  end
end
