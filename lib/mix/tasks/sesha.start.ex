defmodule Mix.Tasks.Dbman.Start do
  @moduledoc """
  Starts the PostgreSQL database server for the project.

  Also creates a `postgres` superuser if one does not exist.

  The following environment variables must be present when this task is run:

    * `PGDATA`
    * `PGHOST`
    * `PGPORT`
    * `LOG_PATH`

  Executed when the user requests `mix dbman.start`."
  """

  use Mix.Task

  @shortdoc "Starts the project database server"
  @requirements ["db.init"]

  def run(_args) do
    shell = Mix.shell()
    pghost = System.fetch_env!("PGHOST")
    pgport = System.fetch_env!("PGPORT")
    log_path = System.fetch_env!("LOG_PATH")

    case shell.cmd("pg_ctl status >/dev/null") do
      0 ->
        shell.info("Database server already started")

      _ ->
        File.mkdir_p!(log_path)
        start_server(shell, pghost, pgport, log_path)
        maybe_create_superuser(shell)
    end
  end

  defp start_server(shell, pghost, pgport, log_path) do
    [
      "pg_ctl",
      ~s(--options "--unix_socket_directories='#{pghost}'"),
      ~s(--options "--port='#{pgport}'"),
      ~s(--log "#{log_path}/postgresql.log"),
      "start"
    ]
    |> Enum.join(" ")
    |> shell.cmd()
  end

  defp maybe_create_superuser(shell) do
    if shell.cmd(~S"psql -c '\du' | grep '^ postgres' >/dev/null") == 1 do
      shell.cmd("createuser -s postgres")
      shell.info("Created postgres superuser")
    end
  end
end
