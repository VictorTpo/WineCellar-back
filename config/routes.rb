# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts,      only: %i[create]
  resources :bottles,       only: %i[create index show update]
  resources :wine_cellars,  only: %i[create index show update]
  resources :sessions,      only: %i[new]
end
