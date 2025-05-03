defmodule Mix.Tasks.Dbman.Init do
  @moduledoc """
  Initializes the PostgreSQL database for the project.

  The following environment variables must be present when this task is run:

    * `PGDATA`

  Executed when the user requests `mix dbman.init`."
  """

  use Mix.Task

  @shortdoc "Initializes the project database"

  def run(_args) do
    shell = Mix.shell()
    pgdata = System.fetch_env!("PGDATA")

    unless File.dir?(pgdata) do
      File.mkdir_p!(pgdata)

      if shell.cmd("initdb --auth=trust >/dev/null") == 0 do
        shell.info("Database initialized")
      else
        shell.error("Database could not be initialized")
      end
    end
  end
end
