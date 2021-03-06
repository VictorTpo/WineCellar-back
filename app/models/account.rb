# frozen_string_literal: true

class Account < ActiveRecord::Base
  has_secure_password

  has_many :wine_cellars, inverse_of: :account, dependent: :destroy
  has_many :bottles, through: :wine_cellars

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true
end
