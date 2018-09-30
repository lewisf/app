defmodule AppWeb.ServerPropertiesController do
  use AppWeb, :controller

  def index(conn, _params) do
    conn
      |> put_view(AppWeb.ServerPropertiesView)
      |> render("index.html")
  end
end
