# frozen_string_literal: true

class Account < ActiveRecord::Base
  has_many :wine_cellars, inverse_of: :account

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :google_id, uniqueness: true
  validates :last_name, presence: true
end
