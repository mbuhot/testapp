defmodule TestappTest do
  use ExUnit.Case
  alias Testapp.Requests

  setup do
    Process.register self(), :requests
    :ok
  end

  test "the truth" do
    _response = HTTPoison.get! "http://localhost:4000/?foo=bar"
    receive do
      conn -> IO.inspect(conn)
    end
  end

  test "the truth 2" do
    _response = HTTPoison.get! "http://localhost:4000/"
    receive do
      req -> IO.inspect(req)
    end
  end
end
