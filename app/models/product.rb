class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }


  # Filtering scopes
  scope :on_sale, -> { where(on_sale: true) }
  scope :not_on_sale, -> { where(on_sale: false) }
  scope :new_arrivals, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago) }
  scope :search_by_name, ->(query) { where("name ILIKE ?", "%#{query}%") }
  scope :filter_by_category, ->(category_id) { where(category_id: category_id) }

  scope :filter_by_sale_status, ->(status) { 
    case status.to_s
    when 'on_sale' then on_sale
    when 'not_on_sale' then not_on_sale
    else all
    end
  }

  # Combined search method
  def self.search(query, category_id = nil)
    products = all
    products = products.search_by_name(query) if query.present?
    products = products.filter_by_category(category_id) if category_id.present?
    products
  end
end