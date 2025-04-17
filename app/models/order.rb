class Order < ApplicationRecord
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements

  before_validation :set_total!

  private

  def set_total!
    self.total = self.products.map(&:price).sum
  end
end
