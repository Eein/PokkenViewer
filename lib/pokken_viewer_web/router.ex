defmodule PokkenViewerWeb.Router do
  use PokkenViewerWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PokkenViewerWeb do
    pipe_through :browser
    live "/", PokkenControllerLive

  end

  # Other scopes may use custom stacks.
  # scope "/api", PokkenViewerWeb do
  #   pipe_through :api
  # end
end
