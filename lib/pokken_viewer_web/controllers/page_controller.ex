defmodule PokkenViewerWeb.PageController do
  use PokkenViewerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
