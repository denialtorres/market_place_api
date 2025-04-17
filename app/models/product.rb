class Product < ApplicationRecord
  belongs_to :user

  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  scope :filter_by_title, lambda { |keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}%")
  }

  scope :above_or_equal_to_price, lambda { |price|
    where("price >= ?", price)
  }

  scope :below_or_equal_to_price, lambda { |price|
    where("price <= ?", price)
  }

  scope :recent, lambda { order(:updated_at) }

  def self.search(params = {})
    products = params[:product_ids].present? ? where(id: params[:product_ids]) : all

    if params[:keyword]
      products = products.filter_by_title(params[:keyword])
    end

    if params[:min_price]
      products = products.above_or_equal_to_price(params[:min_price].to_f)
    end

    if params[:max_price]
      products = products.below_or_equal_to_price(params[:max_price].to_f)
    end

    products
  end
end
