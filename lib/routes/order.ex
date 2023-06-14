defmodule TableCheckHw.Routes.Order do
  @moduledoc """
  Order endpoint router for service
  """
  use Plug.Router

  alias TableCheckHw.Routes.Order

  plug(:match)
  plug(:dispatch)

  get "/v1/orders/restaurants/:restaurant_name/customers/count" do
    Order.Restaurant.CustomersCount.call(conn, [])
  end

  get "/v1/orders/restaurants/:restaurant_name/revenue" do
    Order.Restaurant.Revenue.call(conn, [])
  end

  get "/v1/orders/restaurants/dishes/top" do
    Order.Restaurant.TopDish.call(conn, [])
  end

  get "/v1/orders/restaurants/dishes/profit/top" do
    Order.Restaurant.TopProfitableDish.call(conn, [])
  end

  get "/v1/orders/restaurants/customers/top" do
    Order.Restaurant.TopCustomer.call(conn, [])
  end

  get "/v1/orders/customers/top" do
    Order.TopCustomer.call(conn, [])
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
