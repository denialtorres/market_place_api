require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:one)
    @product1 = products(:one)
    @product2 = products(:two)
  end

  test "Should have a positive total" do
    order = Order.new(total: -1)
    assert_not order.valid?
  end

  test "should set total" do
    order = Order.new user_id: users(:one).id
    order.products << products(:one)
    order.products << products(:two)
    order.save!
    assert_equal (@product1.price + @product2.price), order.total
  end
end
