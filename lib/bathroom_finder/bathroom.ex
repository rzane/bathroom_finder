defmodule BathroomFinder.Bathroom do
  use Ecto.Schema
  import Ecto.Changeset
  alias BathroomFinder.Bathroom


  schema "bathrooms" do
    field :description, :string
    field :label, :string
    field :latitude, :float
    field :longitude, :float

    belongs_to :category, BathroomFinder.Category

    timestamps()
  end

  @doc false
  def changeset(%Bathroom{} = bathroom, attrs) do
    bathroom
    |> cast(attrs, [:label, :latitude, :longitude, :description, :category_id])
    |> validate_required([:label, :latitude, :longitude])
  end
end
