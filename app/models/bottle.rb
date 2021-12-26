# frozen_string_literal: true

class Bottle < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :wine_cellar, inverse_of: :bottles

  validates :counter, comparison: { greater_than_or_equal_to: 0 }
end
