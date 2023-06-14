defmodule TableCheckHw.Schema.Order do
  @moduledoc """
  Schema for Order
  """

  use TableCheckHw, :schema

  schema "orders" do
    field(:restaurant_name, :string)
    field(:food_name, :string)
    field(:first_name, :string)
    field(:food_cost, :float)

    timestamps()
  end
end
