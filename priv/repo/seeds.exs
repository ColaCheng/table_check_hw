# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hello.Repo.insert!(%Hello.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TableCheckHw.Schema.Order
alias TableCheckHw.Repo

unless Mix.env() == :test do
  File.stream!("./data/data.csv")
  |> Stream.drop(1)
  |> Stream.map(fn line ->
    [restaurant_name, food_name, first_name, food_cost] = String.split(line, [",", "\n"], trim: true)
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    %{
      restaurant_name: restaurant_name,
      food_name: food_name,
      first_name: first_name,
      food_cost: String.to_float(food_cost),
      inserted_at: now,
      updated_at: now
    }
  end)
  |> Stream.chunk_every(1000)
  |> Stream.map(fn batch_orders -> Repo.insert_all(Order, batch_orders) end)
  |> Stream.run()
end
