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
    case Application.get_env(:app, :env) do
      :prod ->
        AppWeb.Endpoint.url()
        |> convert_http_to_https()
        |> Kernel.<>("/api/graphql")
      _ -> AppWeb.Endpoint.url() <> "/api/graphql"
    end
  end

  @spec convert_http_to_https(String.t()) :: String.t()
  defp convert_http_to_https(arg) do
    arg
    |> URI.parse()
    |> Map.put(:scheme, "https")
    |> Map.put(:port, nil)
    |> URI.to_string()
  end

  scope "/admin", ExAdmin do
    pipe_through :browser

    admin_routes()
  end

  scope "/", AppWeb do
    pipe_through :browser

    get "/ping", PageController, :ping
    get "/server_properties", ServerPropertiesController, :index
    get "/*path", PageController, :index
  end
end
