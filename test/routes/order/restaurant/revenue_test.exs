defmodule TableCheckHw.Routes.Order.Restaurant.RevenueTest do
  use TableCheckHw.ConnCase

  require Logger

  test "GET /v1/orders/restaurants/:restaurant_name/revenue" do
    cola_count = :rand.uniform(100)
    chips_count = :rand.uniform(100)
    ice_cream_count = :rand.uniform(100)
    insert_list(cola_count, :order, %{restaurant_name: "A", food_name: "cola", food_cost: 2.5})

    insert_list(chips_count, :order, %{restaurant_name: "A", food_name: "chips", food_cost: 5.0})

    insert_list(ice_cream_count, :order, %{
      restaurant_name: "A",
      food_name: "ice cream",
      food_cost: 10.0
    })

    expect = cola_count * 2.5 + chips_count * 5.0 + ice_cream_count * 10.0

    conn = conn(:get, "/v1/orders/restaurants/A/revenue")

    result = Router.call(conn, Router.init([]))
    assert 200 == result.status
    assert ^expect = Jason.decode!(result.resp_body)
  end
end
