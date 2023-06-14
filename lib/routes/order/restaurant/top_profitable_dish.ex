defmodule TableCheckHw.Routes.Order.Restaurant.TopProfitableDish do
  @moduledoc """
  A HTTP request handler for getting the most profitable dish at restaurant.
  """
  @behaviour Plug

  import Plug.Conn
  alias TableCheckHw.Order

  @impl Plug
  def init(options), do: options

  @impl Plug
  def call(conn, _options) do
    {:ok, body} =
      Order.get_the_most_profitable_dish_at_restaurant()
      |> Jason.encode()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
