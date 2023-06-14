defmodule TableCheckHw.Routes.Order.Restaurant.TopDish do
  @moduledoc """
  A HTTP request handler for getting the most popular dish at restaurant.
  """
  @behaviour Plug

  import Plug.Conn
  alias TableCheckHw.Order

  @impl Plug
  def init(options), do: options

  @impl Plug
  def call(conn, _options) do
    {:ok, body} =
      Order.get_the_most_popular_dish_at_restaurant()
      |> Jason.encode()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
