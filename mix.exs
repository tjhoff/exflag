defmodule ExFlag.MixProject do
  use Mix.Project

  def project do
    [
      app: :exflag,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "ExFlag",
      source_url: "https://github.com/tjhoff/exflag"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:poison, "~> 3.1"}
    ]
  end

  defp description() do
    "ExFlag is a feature flag library for elixir with multiple options."
  end

  defp package() do
    [
      name: "exflag",
      licenses: ["Apache 2.0"],
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      links: %{"GitHub" => "https://github.com/tjhoff/exflag"}
    ]
  end
end
