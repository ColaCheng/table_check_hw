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

    timestamps(type: :naive_datetime_usec)
  end

  @spec __to_map__(%__MODULE__{}) :: map()
  def __to_map__(%__MODULE__{} = data) do
    __MODULE__.__schema__(:fields)
    |> Enum.map(&{__MODULE__.__schema__(:field_source, &1), &1, __MODULE__.__schema__(:type, &1)})
    |> Enum.map(fn {map_key, str_field, type} ->
      {map_key, data |> Map.fetch!(str_field), type}
    end)
    |> Enum.map(fn {map_key, str_value, type} ->
      {map_key, Ecto.Type.dump(type, str_value)}
    end)
    |> Enum.reduce([], fn
      {_map_key, {:ok, nil}}, acc ->
        acc

      {map_key, {:ok, value}}, acc ->
        [{map_key, value} | acc]
    end)
    |> Enum.into(%{})
  end
end
