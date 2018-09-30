defmodule AppWeb.Router do
  use AppWeb, :router
  use ExAdmin.Router

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

  pipeline :graphql do
    plug AppWeb.Context
  end

  # Other scopes may use custom stacks.
  scope "/api" do
    pipe_through :graphql

    forward "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: AppWeb.Schema,
      interface: :playground,
      default_url: {__MODULE__, :graphql_default_url}
    forward "/",
      Absinthe.Plug,
      schema: AppWeb.Schema
  end

  def graphql_default_url do
    case Mix.env() do
      :prod ->
        AppWeb.Endpoint.url()
          |> URI.parse()
          |> Map.put(:scheme, "https")
          |> URI.to_string()
          |> Kernel.<>("/api/graphql")
      _ -> AppWeb.Endpoint.url() <> "/api/graphql"
    end
  end

  scope "/admin", ExAdmin do
    pipe_through :browser

    admin_routes()
  end

  scope "/", AppWeb do
    pipe_through :browser

    get "/*path", PageController, :index
    get "/ping", PageController, :ping
  end
end
