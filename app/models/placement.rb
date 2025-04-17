class Placement < ApplicationRecord
  belongs_to :order
  belongs_to :product, inverse_of: :placements

  after_create :decrease_product_quantity!

  def decrease_product_quantity!
    product.decrement!(:quantity, quantity)
  end
end
