# frozen_string_literal: true

class WineCellar < ActiveRecord::Base
  belongs_to :account, inverse_of: :wine_cellars

  validates :name, presence: true
end
