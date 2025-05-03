defmodule Mix.Tasks.Dbman.Stop do
  @moduledoc """
  Stops the PostgreSQL database server for the project.

  Executed when the user requests `mix dbman.stop`."
  """

  use Mix.Task

  @shortdoc "Stops the project database server"

  def run(_args) do
    Mix.shell().cmd("pg_ctl stop")
  end
end
