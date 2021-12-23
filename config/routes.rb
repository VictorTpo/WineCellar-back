# frozen_string_literal: true

Rails.application.routes.draw do
  resources :accounts, only: :create
  resources :bottles, only: :create
end
