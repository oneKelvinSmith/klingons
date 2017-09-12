defmodule KlingonsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :klingons

  socket "/socket", KlingonsWeb.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :klingons, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_klingons_key",
    signing_salt: "GJ4WNYAc"

  plug KlingonsWeb.Router

  @doc """
  Callback invoked for dynamically configuring the endpoint.

  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, config) do
    if config[:load_from_system_env] do
      {:ok,
       config
       |> Keyword.put(:http, [:inet6, port: get_env("PORT")])
       |> Keyword.put(:url, [host: config[:url][:host], port: get_env("PORT")])
       |> Keyword.put(:secret_key_base, get_env("SECRET_KEY_BASE"))}
    else
      {:ok, config}
    end
  end

  defp get_env(variable) do
    System.get_env(variable)
    || raise "expected the #{variable} environment variable to be set"
  end
end
