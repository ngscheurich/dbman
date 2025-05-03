defmodule Dbman.MixProject do
  use Mix.Project

  @source_url "https://github.com/ngscheurich/dbman"
  @version "0.1.1"

  def project do
    [
      app: :dbman,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: "Database helper",
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  def package do
    %{
      maintainers: ["Nicholas Scheurich"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    }
  end
end
