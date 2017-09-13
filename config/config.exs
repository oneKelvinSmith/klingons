use Mix.Config

config :klingons,
  ecto_repos: [Klingons.Repo]

config :klingons, KlingonsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YP+IacPJRpDbk5dxK0o2msL+eINcx5wCM7eLiee42hFJ2ptCvG64MS+L10fYDO71",
  render_errors: [view: KlingonsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Klingons.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mix_docker, image: "onekelvinsmith/klingons"

import_config "#{Mix.env}.exs"
