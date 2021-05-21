defmodule ExGdax.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_gdax,
      version: "0.1.6",
      elixir: "~> 1.10",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package(),
      name: "ExGdax",
      description: "GDAX API client for Elixir",
      source_url: "https://github.com/bnhansn/ex_gdax"
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 4.0"},
      {:mock, "~> 0.3", only: :test},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end

  defp docs do
    [
      main: "ExGdax",
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      name: :ex_gdax,
      maintainers: ["Ben Hansen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/bnhansn/ex_gdax"}
    ]
  end
end
