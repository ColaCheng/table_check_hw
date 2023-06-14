defmodule TableCheckHw.Routes.Order.Restaurant.TopCustomerTest do
  use TableCheckHw.ConnCase

  require Logger

  test "GET /v1/orders/restaurants/customers/top" do
    a_customer_count = 200
    b_customer_count = 150
    c_customer_count = 100

    insert_list(a_customer_count, :order, %{
      restaurant_name: "A",
      first_name: "Robert"
    })

    insert_list(:rand.uniform(a_customer_count - 1), :order, %{restaurant_name: "A"})

    insert_list(b_customer_count, :order, %{
      restaurant_name: "B",
      first_name: "Alice"
    })

    insert_list(:rand.uniform(b_customer_count - 1), :order, %{restaurant_name: "B"})

    insert_list(c_customer_count, :order, %{
      restaurant_name: "C",
      first_name: "Bob"
    })

    insert_list(:rand.uniform(c_customer_count - 1), :order, %{restaurant_name: "C"})

    expect = [
      %{"visit_count" => a_customer_count, "first_name" => "Robert", "restaurant_name" => "A"},
      %{"visit_count" => b_customer_count, "first_name" => "Alice", "restaurant_name" => "B"},
      %{"visit_count" => c_customer_count, "first_name" => "Bob", "restaurant_name" => "C"}
    ]

    conn = conn(:get, "/v1/orders/restaurants/customers/top")

    result = Router.call(conn, Router.init([]))
    assert 200 == result.status
    assert ^expect = Jason.decode!(result.resp_body)
  end
end
