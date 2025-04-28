class Page < ApplicationRecord
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  
  # Add these validations if needed
  validates :phone, format: { with: /\A\+?[\d\s\-()]{7,}\z/, allow_blank: true }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
end
