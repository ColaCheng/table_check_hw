defmodule TableCheckHw.Routes.Public do
  @moduledoc """
  Public endpoint router for service
  """
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  forward("/", to: TableCheckHw.Routes.Order)
end
