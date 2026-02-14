defmodule SnethembaWeb.PageController do
  use SnethembaWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
