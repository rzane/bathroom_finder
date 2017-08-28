defmodule BathroomFinderWeb.Router do
  use BathroomFinderWeb, :router

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

  scope "/" do
    get "/graphiql", Absinthe.Plug.GraphiQL, schema: BathroomFinderWeb.Schema
    forward "/graphql", Absinthe.Plug, schema: BathroomFinderWeb.Schema
  end

  scope "/", BathroomFinderWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BathroomFinderWeb do
  #   pipe_through :api
  # end
end
