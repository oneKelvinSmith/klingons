# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :klingons,
  ecto_repos: [Klingons.Repo]

# Configures the endpoint
config :klingons, KlingonsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YP+IacPJRpDbk5dxK0o2msL+eINcx5wCM7eLiee42hFJ2ptCvG64MS+L10fYDO71",
  render_errors: [view: KlingonsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Klingons.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
