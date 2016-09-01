defmodule Testapp.Mixfile do
  use Mix.Project

  def project do
    [app: :testapp,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :cowboy, :plug, :poison, :httpoison],
     mod: {Testapp, []}]
  end

  defp deps do
    [{:cowboy, "~> 1.0.0"},
     {:plug, "~> 1.2.0"},
     {:poison, "~> 2.2.0"},
     {:httpoison, "~> 0.9.0"}]
  end
end
