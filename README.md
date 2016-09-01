# testapp

Runs a Plug server during tests.

# Usage

```
mix test
```

# Implementation

The application starts the cowboy server with a plug router.
The `Conn` for each request that is received is sent to the registered `:requests` process.

```Elixir
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
```

Test process registers itself during setup:

```Elixir
  setup do
    Process.register self(), :requests
    :ok
  end
```

Tests make HTTP requests, then wait for the request info to be sent back to the test process:

```Elixir
  test "the truth" do
    _response = HTTPoison.get! "http://localhost:4000/?foo=bar"
    receive do
      conn -> IO.inspect(conn)
    end
  end
```
