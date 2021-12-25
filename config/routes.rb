# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts, only: :create
  resources :bottles, only: :create
  resources :wine_cellars, only: %i[create show index]
  resources :sessions, only: :new
end
