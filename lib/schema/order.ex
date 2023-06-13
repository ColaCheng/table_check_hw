defmodule TableCheckHw.Schema.Order do
  use TableCheckHw, :schema

  schema "orders" do
    field(:restaurant_name, :string)
    field(:food_name, :string)
    field(:first_name, :string)
    field(:food_cost, :float)

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:restaurant_name, :food_name, :first_name, :food_cost])
    |> validate_required([:restaurant_name, :food_name, :first_name, :food_cost])
  end
end
