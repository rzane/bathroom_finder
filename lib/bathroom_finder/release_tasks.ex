defmodule BathroomFinder.ReleaseTasks do
  alias BathroomFinder.Repo

  def setup do
    start_requirements()
    create_database()
    establish_connection()
    run_migrations()
    seed_database()
  end

  defp create_database do
    case Repo.__adapter__.storage_up(Repo.config) do
      :ok ->
        IO.puts("The database has been created")

      {:error, :already_up} ->
        IO.puts("The database has already been created")

      {:error, term} ->
        raise "The database couldn't be created: #{inspect term}"
    end
  end

  defp seed_database do
    :bathroom_finder
    |> Application.app_dir("priv/repo/seeds.exs")
    |> Code.load_file()
  end

  defp run_migrations do
    dir = Application.app_dir(:bathroom_finder, "priv/repo/migrations")
    Ecto.Migrator.run(Repo, dir, :up, all: true)
  end

  defp establish_connection do
    {:ok, _} = Repo.start_link(pool_size: 1)
  end

  defp start_requirements do
    :ok = Application.load(:bathroom_finder)
    {:ok, _} = Application.ensure_all_started(:crypto)
    {:ok, _} = Application.ensure_all_started(:ssl)
    {:ok, _} = Application.ensure_all_started(:postgrex)
    {:ok, _} = Application.ensure_all_started(:ecto)
  end
end
