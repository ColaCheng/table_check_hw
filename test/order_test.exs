defmodule TableCheckHw.OrderTest do
  use TableCheckHw.DataCase

  alias TableCheckHw.Order

  describe "count_customers_by_restaurant_name/1" do
    test "able to count customers by restaurant" do
      restaurant_a_order_count = :rand.uniform(100)
      restaurant_b_order_count = :rand.uniform(100)
      insert_list(restaurant_a_order_count, :order, %{restaurant_name: "A"})
      insert_list(restaurant_b_order_count, :order, %{restaurant_name: "B"})
      assert Order.count_customers_by_restaurant_name("A") == restaurant_a_order_count
      assert Order.count_customers_by_restaurant_name("B") == restaurant_b_order_count
    end
  end

  describe "sum_revenue_by_restaurant_name/1" do
    test "able to sum revenue by restaurant" do
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

      assert expect == Order.sum_revenue_by_restaurant_name("A")
    end
  end

  describe "get_the_most_popular_dish_at_restaurant/0" do
    test "able to get the most popular dish at restaurant" do
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
        %{count: a_cola1_count, food_name: "cola1", restaurant_name: "A"},
        %{count: b_cola2_count, food_name: "cola2", restaurant_name: "B"},
        %{count: c_cola3_count, food_name: "cola3", restaurant_name: "C"}
      ]

      assert ^expect = Order.get_the_most_popular_dish_at_restaurant()
    end
  end

  describe "get_the_most_profitable_dish_at_restaurant/0" do
    test "able to get the most profitable dish at restaurant" do
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

      expect =
        [
          %{sum: a_cola1_count * 2.5, food_name: "cola1", restaurant_name: "A"},
          %{sum: b_cola2_count * 5.0, food_name: "cola2", restaurant_name: "B"},
          %{sum: c_cola3_count * 10.0, food_name: "cola3", restaurant_name: "C"}
        ]
        |> Enum.sort_by(&Map.get(&1, :sum), :desc)

      assert ^expect = Order.get_the_most_profitable_dish_at_restaurant()
    end
  end

  describe "get_the_top_customer_at_restaurant/0" do
    test "able to get the top customer at restaurant" do
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
        %{visit_count: a_customer_count, first_name: "Robert", restaurant_name: "A"},
        %{visit_count: b_customer_count, first_name: "Alice", restaurant_name: "B"},
        %{visit_count: c_customer_count, first_name: "Bob", restaurant_name: "C"}
      ]

      assert ^expect = Order.get_the_top_customer_at_restaurant()
    end
  end

  describe "get_the_top_customer/0" do
    test "able to get the top customer for all restaurant" do
      a_customer_count = 200
      b_customer_count = 150
      c_customer_count = 100

      insert_list(a_customer_count, :order, %{first_name: "Robert"})
      insert_list(b_customer_count, :order, %{first_name: "Alice"})
      insert_list(c_customer_count, :order, %{first_name: "Bob"})

      expect = %{visit_count: a_customer_count, first_name: "Robert"}

      assert ^expect = Order.get_the_top_customer()
    end
  end
end
