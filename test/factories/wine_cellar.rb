# frozen_string_literal: true

FactoryBot.define do
  factory :wine_cellar do
    name { Faker::Lorem.word }
    association :account
  end

  factory :wine_cellar__d, class: 'WineCellar' do
    name { Faker::Lorem.word }
    association :account, factory: :account__d
  end
end
