defmodule TableCheckHw.Routes.Order.Restaurant.CustomersCountTest do
  use TableCheckHw.ConnCase

  require Logger

  test "GET /v1/orders/restaurants/:restaurant_name/customers/count" do
    restaurant_a_order_count = :rand.uniform(100)
    restaurant_b_order_count = :rand.uniform(100)
    insert_list(restaurant_a_order_count, :order, %{restaurant_name: "A"})
    insert_list(restaurant_b_order_count, :order, %{restaurant_name: "B"})

    conn1 = conn(:get, "/v1/orders/restaurants/A/customers/count")
    result1 = Router.call(conn1, Router.init([]))
    assert 200 == result1.status
    assert ^restaurant_a_order_count = Jason.decode!(result1.resp_body)

    conn2 = conn(:get, "/v1/orders/restaurants/B/customers/count")
    result2 = Router.call(conn2, Router.init([]))
    assert 200 == result2.status
    assert ^restaurant_b_order_count = Jason.decode!(result2.resp_body)
  end
end
