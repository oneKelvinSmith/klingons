defmodule KlingonsWeb.PageController do
  use KlingonsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
