defmodule BathroomFinder.Bathroom do
  use Ecto.Schema
  import Ecto.Changeset
  alias BathroomFinder.Bathroom


  schema "bathrooms" do
    field :description, :string
    field :label, :string
    field :latitude, :float
    field :longitude, :float

    timestamps()
  end

  @doc false
  def changeset(%Bathroom{} = bathroom, attrs) do
    bathroom
    |> cast(attrs, [:label, :latitude, :longitude, :description])
    |> validate_required([:label, :latitude, :longitude])
  end
end
