# frozen_string_literal: true

json.array! @bottles, partial: 'bottles/bottle', as: :bottle
