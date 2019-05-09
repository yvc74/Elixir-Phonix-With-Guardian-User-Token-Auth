defmodule ApppWeb.HomeController do
  use ApppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
