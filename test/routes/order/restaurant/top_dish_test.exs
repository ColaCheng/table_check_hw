defmodule TableCheckHw.Routes.Order.Restaurant.TopDishTest do
  use TableCheckHw.ConnCase

  require Logger

  test "GET /v1/orders/restaurants/dishes/top" do
    a_cola1_count = 200
    b_cola2_count = 150
    c_cola3_count = 100

    insert_list(a_cola1_count, :order, %{
      restaurant_name: "A",
      food_name: "cola1",
      food_cost: 2.5
    })

    insert_list(10, :order, %{restaurant_name: "A", food_cost: 1.0})

    insert_list(b_cola2_count, :order, %{
      restaurant_name: "B",
      food_name: "cola2",
      food_cost: 5.0
    })

    insert_list(10, :order, %{restaurant_name: "B", food_cost: 1.0})

    insert_list(c_cola3_count, :order, %{
      restaurant_name: "C",
      food_name: "cola3",
      food_cost: 10.0
    })

    insert_list(10, :order, %{restaurant_name: "C", food_cost: 1.0})

    expect = [
      %{"count" => a_cola1_count, "food_name" => "cola1", "restaurant_name" => "A"},
      %{"count" => b_cola2_count, "food_name" => "cola2", "restaurant_name" => "B"},
      %{"count" => c_cola3_count, "food_name" => "cola3", "restaurant_name" => "C"}
    ]

    conn = conn(:get, "/v1/orders/restaurants/dishes/top")

    result = Router.call(conn, Router.init([]))
    assert 200 == result.status
    assert ^expect = Jason.decode!(result.resp_body)
  end
end
