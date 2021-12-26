# frozen_string_literal: true

class Account < ActiveRecord::Base
  has_many :wine_cellars, inverse_of: :account
  has_many :bottles, through: :wine_cellars

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_uniqueness_of :google_id, conditions: -> { where.not(google_id: nil) }
end
