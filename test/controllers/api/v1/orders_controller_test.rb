require "test_helper"

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @order_params = { order: { product_ids: [ products(:one).id, products(:two).id ], total: 100 } }
  end

  test "should forbid orders for unlogged" do
    get api_v1_orders_url, as: :json
    assert_response :forbidden
  end

  test "should show orders" do
    get api_v1_orders_url,
    headers: { "Authorization" => JsonWebToken.encode(user_id: @order.user.id) },
    as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @order.user.orders.count, json_response["data"].length
  end

  test "should show order details" do
    get api_v1_order_url(@order),
    headers: { "Authorization" => JsonWebToken.encode(user_id: @order.user.id) },
    as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @order.id.to_s, json_response["data"]["id"]
    include_product_attr = json_response["included"][0]["attributes"]
    assert_equal @order.products.first.title, include_product_attr["title"]
  end

  test "should forbid orders for unauthorized users" do
    assert_no_difference "Order.count" do
      post api_v1_orders_url,
      params: @order_params,
      as: :json
    end

    assert_response :forbidden
  end

  test "should create order" do
    assert_difference "Order.count", 1 do
      post api_v1_orders_url,
      params: @order_params,
      headers: { "Authorization" => JsonWebToken.encode(user_id: @order.user.id) },
      as: :json
    end

    assert_response :created
  end
end
