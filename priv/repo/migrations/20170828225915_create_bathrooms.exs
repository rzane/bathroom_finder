defmodule BathroomFinder.Repo.Migrations.CreateBathrooms do
  use Ecto.Migration

  def change do
    create table(:bathrooms) do
      add :label, :string
      add :latitude, :float
      add :longitude, :float
      add :description, :text

      timestamps()
    end

  end
end
