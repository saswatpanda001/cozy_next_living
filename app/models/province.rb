class Province < ApplicationRecord
    has_many :admins
    validates :gst, :hst, :pst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
