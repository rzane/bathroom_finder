defmodule BathroomFinderWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias BathroomFinderWeb.Schema.Resolver

  object :bathroom do
    field :id, :id
    field :label, :string
    field :latitude, :float
    field :longitude, :float
    field :description, :string

    field :distance, :float do
      arg :coordinates, non_null(:coordinates_input)
      resolve &Resolver.distance/3
    end
  end

  input_object :bathroom_input do
    field :label, :string
    field :latitude, :float
    field :longitude, :float
    field :description, :string
  end

  input_object :coordinates_input do
    field :latitude, non_null(:float)
    field :longitude, non_null(:float)
  end
end
