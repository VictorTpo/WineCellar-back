# frozen_string_literal: true

class Bottle < ActiveRecord::Base
  validates :name, presence: true
end
