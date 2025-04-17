class Order < ApplicationRecord
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements

  before_validation :set_total!

  # @param product_ids [Array<Hash>] something like this
  # `[{product_id: 1, quantity: 2}, {product_id: 2, quantity: 3}]
  # @yield [Placement] placements build
  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      placement = placements.build(product_id: product_id_and_quantity[:product_id],
                                    quantity: product_id_and_quantity[:quantity])
      yield placement if block_given?
    end
  end

  private

  def set_total!
    self.total = self.products.map(&:price).sum
  end
end
