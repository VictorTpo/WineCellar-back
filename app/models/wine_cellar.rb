# frozen_string_literal: true

class WineCellar < ActiveRecord::Base
  belongs_to :account, inverse_of: :wine_cellars
  has_many :bottles, inverse_of: :wine_cellar, dependent: :destroy

  validates :name, presence: true
end
