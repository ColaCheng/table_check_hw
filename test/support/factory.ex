defmodule TableCheckHw.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: TableCheckHw.Repo

  alias TableCheckHw.Schema.Order

  def order_factory(attrs) do
    restaurant_name =
      case Map.get(attrs, :restaurant_name) do
        nil ->
          sequence(:restaurant_name, [
            "the-restaurant-at-the-end-of-the-universe",
            "johnnys-cashew-stand",
            "bean-juice-stand",
            "the-ice-cream-parlor"
          ])

        v ->
          v
      end

    food_name =
      case Map.get(attrs, :food_name) do
        nil ->
          sequence(:food_name, [
            "beans",
            "cashews",
            "chips",
            "chocolate",
            "coffee",
            "cookies",
            "corn",
            "candy",
            "cereal",
            "chicken",
            "cheese",
            "eggs",
            "fish",
            "fruit",
            "grains",
            "honey",
            "ice cream",
            "juice",
            "milk",
            "meat",
            "nuts",
            "oil",
            "pasta",
            "rice",
            "salad",
            "sandwiches",
            "soup",
            "spices",
            "sugar",
            "tea",
            "vegetables",
            "water",
            "wine",
            "yogurt"
          ])

        v ->
          v
      end

    first_name =
      case Map.get(attrs, :first_name) do
        nil -> sequence("Alexandra")
        v -> v
      end

    food_cost =
      case Map.get(attrs, :food_cost) do
        nil ->
          sequence(:food_cost, [
            1.00,
            1.50,
            2.00,
            2.50,
            3.00,
            3.50,
            4.00,
            4.50,
            5.00,
            5.50,
            6.00,
            6.50,
            7.00,
            7.50,
            8.00,
            8.50,
            9.00
          ])

        v ->
          v
      end

    %Order{
      restaurant_name: restaurant_name,
      food_name: food_name,
      first_name: first_name,
      food_cost: food_cost
    }
  end
end
