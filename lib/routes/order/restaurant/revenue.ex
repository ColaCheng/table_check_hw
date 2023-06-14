defmodule TableCheckHw.Routes.Order.Restaurant.Revenue do
  @moduledoc """
  A HTTP request handler for getting sum revenue by restaurant_name.
  """
  @behaviour Plug

  import Plug.Conn
  alias TableCheckHw.Order

  @impl Plug
  def init(options), do: options

  @impl Plug
  def call(%{path_params: %{"restaurant_name" => restaurant_name}} = conn, _options) do
    {:ok, body} =
      Order.get_revenue_by_restaurant_name(restaurant_name)
      |> Jason.encode()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
