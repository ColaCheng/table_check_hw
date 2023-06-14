defmodule TableCheckHw.Routes.Order.TopCustomer do
  @moduledoc """
  A HTTP request handler for getting the top customer.
  """
  @behaviour Plug

  import Plug.Conn
  alias TableCheckHw.Order

  @impl Plug
  def init(options), do: options

  @impl Plug
  def call(conn, _options) do
    {:ok, body} =
      Order.get_the_top_customer()
      |> Jason.encode()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
