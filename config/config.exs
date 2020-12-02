# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_mon_web,
  ecto_repos: [ExMonWeb.Repo]

# Configures the endpoint
config :ex_mon_web, ExMonWebWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7RRrqiVSJyQETPOe5/b0s9S4wuAA7S5OD35KqBxap+6lXIxbVAff0CPZ1lFDNnDv",
  render_errors: [view: ExMonWebWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExMonWeb.PubSub,
  live_view: [signing_salt: "78QhRCxd"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
