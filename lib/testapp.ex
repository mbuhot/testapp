defmodule Testapp do
  use Application
  def start(_type, _args) do
    Plug.Adapters.Cowboy.http Testapp.Router, []
  end

  defmodule Router do
    use Plug.Router
    plug Plug.Parsers, parsers: [:urlencoded, :json]
    plug :match
    plug :dispatch

    get "/" do
      send :requests, conn
      send_resp conn, 200, "response"
    end
  end
end
