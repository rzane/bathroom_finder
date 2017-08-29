defmodule BathroomFinder.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string

      timestamps()
    end

    alter table(:bathrooms) do
      add :category_id, references(:categories)
    end
  end
end
