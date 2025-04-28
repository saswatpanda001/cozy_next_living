class Admin < ApplicationRecord
    belongs_to :province
    has_many :orders, dependent: :destroy
    has_secure_password
  
    validates :username, presence: true, uniqueness: true
    validates :province_id, presence: true   # <-- require a province
  end
  
  