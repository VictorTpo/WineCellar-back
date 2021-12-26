# frozen_string_literal: true

class Bottle < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :wine_cellar, inverse_of: :bottles
end
