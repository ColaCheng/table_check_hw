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
alias TableCheckHw.Parsers.CSV

unless Mix.env() == :test do
  CSV.stream("./data/data.csv")
  |> Stream.chunk_every(1000)
  |> Stream.map(fn batch_orders -> Repo.insert_all(Order, batch_orders) end)
  |> Stream.run()
end
