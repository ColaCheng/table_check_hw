defmodule TableCheckHw.Routes.Order.TopCustomerTest do
  use TableCheckHw.ConnCase

  require Logger

  test "GET /v1/orders/customers/top" do
    a_customer_count = 200
    b_customer_count = 150
    c_customer_count = 100

    insert_list(a_customer_count, :order, %{first_name: "Robert"})
    insert_list(b_customer_count, :order, %{first_name: "Alice"})
    insert_list(c_customer_count, :order, %{first_name: "Bob"})

    expect = %{"visit_count" => a_customer_count, "first_name" => "Robert"}

    conn = conn(:get, "/v1/orders/customers/top")

    result = Router.call(conn, Router.init([]))
    assert 200 == result.status
    assert ^expect = Jason.decode!(result.resp_body)
  end
end
