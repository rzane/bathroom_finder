defmodule BathroomFinderWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :bathroom do
    field :id, :id
    field :label, :string
    field :latitude, :float
    field :longitude, :float
    field :description, :string
  end

  input_object :bathroom_input do
    field :label, :string
    field :latitude, :float
    field :longitude, :float
    field :description, :string
  end
end
