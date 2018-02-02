defmodule BathroomFinder.ReleaseTasks do
  alias BathroomFinder.Repo

  def create do
    start_requirements()

    case Repo.__adapter__.storage_up(Repo.config) do
      :ok ->
        IO.puts("The database has been created")

      {:error, :already_up} ->
        IO.puts("The database has already been created")

      {:error, term} ->
        raise "The database couldn't be created: #{inspect term}"
    end
  end

  def migrate do
    {:ok, _} = Application.ensure_all_started(:bathroom_finder)
    dir = Application.app_dir(:bathroom_finder, "priv/repo/migrations")
    Ecto.Migrator.run(Repo, dir, :up, all: true)
  end

  defp start_requirements do
    :ok = Application.load(:bathroom_finder)
    {:ok, _} = Application.ensure_all_started(:crypto)
    {:ok, _} = Application.ensure_all_started(:ssl)
    {:ok, _} = Application.ensure_all_started(:postgrex)
    {:ok, _} = Application.ensure_all_started(:ecto)
  end
end
