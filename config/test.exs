import Config

config :table_check_hw, TableCheckHw.Repo,
  username: "postgres",
  password: "postgres",
  database: "table_check_hw_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
