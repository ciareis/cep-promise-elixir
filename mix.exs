defmodule CepPromise.MixProject do
  use Mix.Project

  def project do
    [
      app: :cep_promise,
      version: "0.0.2",
      description: "Cep Promise",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps()
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Leandro Henrique"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ciareis/cep-promise-elixir"}
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
      {:tesla, "~> 1.4.0"}
    ]
  end
end
