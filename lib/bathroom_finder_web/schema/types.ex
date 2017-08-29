defmodule BathroomFinderWeb.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: BathroomFinder.Repo

  alias BathroomFinderWeb.Schema.Resolver

  object :bathroom do
    field :id, :id
    field :label, :string
    field :latitude, :float
    field :longitude, :float
    field :description, :string
    field :category_id, :id
    field :category, :category, resolve: assoc(:category)

    field :distance, :float do
      arg :coordinates, non_null(:coordinates_input)
      resolve &Resolver.distance/3
    end
  end

  object :category do
    field :id, :id
    field :name, :string
  end

  input_object :bathroom_input do
    field :label, :string
    field :latitude, :float
    field :longitude, :float
    field :description, :string
    field :category_id, :id
  end

  input_object :coordinates_input do
    field :latitude, non_null(:float)
    field :longitude, non_null(:float)
  end
end
