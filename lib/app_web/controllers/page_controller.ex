defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_content_type("text/plain", "utf-8")
    |> send_resp(404, "Not found")
  end

  def ping(conn, _params) do
    conn
    |> put_resp_content_type("text/plain", "utf-8")
    |> send_resp(200, "pong")
  end
end
