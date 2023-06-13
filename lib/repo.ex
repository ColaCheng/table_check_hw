defmodule TableCheckHw.Repo do
  use Ecto.Repo,
    otp_app: :table_check_hw,
    adapter: Ecto.Adapters.Postgres
end
