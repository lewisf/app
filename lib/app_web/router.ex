defmodule AppWeb.Router do
  use AppWeb, :router

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

  scope "/", AppWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api" do
    pipe_through :api

    forward "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: AppWeb.Schema,
      interface: :playground,
      default_url: {__MODULE__, :graphql_default_url}

    forward "/",
      Absinthe.Plug,
      schema: AppWeb.Schema
  end

  def graphql_default_url, do: AppWeb.Endpoint.url() <> "/api"
end
