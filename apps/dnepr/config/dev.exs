use Mix.Config

# Configure your database
config :dnepr, Dnepr.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "dnepr_dev",
  hostname: "localhost",
  pool_size: 10
