defmodule CepPromise.MixProject do
  use Mix.Project

  @app :cep_promise
  @version "0.0.3"
  @repo "https://github.com/ciareis/cep-promise-elixir"
  @name "Cep Promise"

  def project do
    [
      app: @app,
      version: @version,
      name: @name,
      description: description(),
      start_permanent: Mix.env() == :prod,
      package: package(),
      docs: docs(),
      deps: deps()
    ]
  end

  defp description do
    """
    Find Brazilian addresses by postal code.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      extras: ~w(README.md),
      maintainers: ["Leandro Henrique"],
      licenses: ["MIT"],
      links: %{"GitHub" => @repo}
    ]
  end

  defp docs() do
    [
      main: "readme",
      extras: ~w(README.md),
      formatters: ["html"],
      source_ref: @version,
      source_url: @repo,
      canonical: "https://hexdocs.pm/cep_promise"
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
      {:ex_doc, "~> 0.18", only: :dev},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:tesla, "~> 1.4.0"},
      {:jason, ">= 1.0.0"}
    ]
  end
end
