require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "should have a positive price" do
    product = products(:one)
    product.price = -10
    assert_not product.valid?
  end
end
