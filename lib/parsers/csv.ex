defmodule TableCheckHw.Parsers.CSV do
  @moduledoc """
  For parsing the data from the csv file.
  """

  @spec stream(file_path :: String.t()) :: Enumerable.t()
  def stream(file_path) do
    File.stream!(file_path)
    |> Stream.drop(1)
    |> Stream.map(fn line ->
      [restaurant_name, food_name, first_name, food_cost] =
        String.split(line, [",", "\n"], trim: true)

      now = NaiveDateTime.utc_now()

      %{
        restaurant_name: restaurant_name,
        food_name: food_name,
        first_name: first_name,
        food_cost: String.to_float(food_cost),
        inserted_at: now,
        updated_at: now
      }
    end)
  end
end
