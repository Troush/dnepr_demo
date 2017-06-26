use Mix.Config

config :dnepr, ecto_repos: [Dnepr.Repo]

import_config "#{Mix.env}.exs"
