defmodule BathroomFinderWeb.PageController do
  use BathroomFinderWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
