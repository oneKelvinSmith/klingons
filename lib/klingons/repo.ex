defmodule Klingons.Repo do
  use Ecto.Repo, otp_app: :klingons

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, config) do
    if config[:load_from_system_env] do
      {:ok, Keyword.put(config, :url, System.get_env("DATABASE_URL"))}
    else
      {:ok, config}
    end
  end
end
