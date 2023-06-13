import Config

# Configure your database
config :table_check_hw, TableCheckHw.Repo,
  username: "postgres",
  password: "postgres",
  database: "table_check_hw_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
