# frozen_string_literal: true

class Account < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :google_id, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
