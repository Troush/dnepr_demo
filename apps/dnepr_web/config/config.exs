# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dnepr_web,
  namespace: Dnepr.Web,
  ecto_repos: [Dnepr.Repo]

# Configures the endpoint
config :dnepr_web, Dnepr.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "R5qe0qoQvt6lQXb0fl8CcOR154y9YsjmZJF8BI8XfqfzCdw8piFpcU3wzF/+tFgd",
  render_errors: [view: Dnepr.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: Dnepr.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :dnepr_web, :generators,
  context_app: :dnepr

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
