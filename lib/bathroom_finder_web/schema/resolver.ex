defmodule BathroomFinderWeb.Schema.Resolver do
  import Ecto.Query
  alias BathroomFinder.{Repo, Bathroom, Category}

  @distance_query "select geodistance($1, $2, $3, $4)"

  def all(%{coordinates: coordinates}, _info) do
    query = from b in Bathroom, order_by: fragment(
      "geodistance(?, ?, ?, ?)",
      b.latitude,
      b.longitude,
      ^coordinates.latitude,
      ^coordinates.longitude
    )

    {:ok, Repo.all(query)}
  end

  def all(_args, _info) do
    {:ok, Repo.all(Bathroom)}
  end

  def categories(_args, _info) do
    {:ok, Repo.all(Category)}
  end

  def find(%{id: id}, _info) do
    {:ok, Repo.get(Bathroom, id)}
  end

  def distance(bathroom, %{coordinates: coordinates}, _info) do
    {:ok, get_distance(bathroom, coordinates)}
  end

  def create(%{bathroom: input}, _info) do
    %Bathroom{}
    |> Bathroom.changeset(input)
    |> Repo.insert
    |> translate()
  end

  def update(%{id: id, bathroom: input}, _info) do
    Bathroom
    |> Repo.get!(id)
    |> Bathroom.changeset(input)
    |> Repo.update
    |> translate()
  end

  def delete(%{id: id}, _info) do
    Bathroom
    |> Repo.get!(id)
    |> Repo.delete
    |> translate()
  end

  defp get_distance(%Bathroom{latitude: a, longitude: b}, %{latitude: c, longitude: d}) do
    %{rows: [[value]]} = Ecto.Adapters.SQL.query!(Repo, @distance_query, [a, b, c, d])
    value
  end

  defp translate({:error, %Ecto.Changeset{} = changeset}) do
    errors = for {key, {message, _}} <- changeset.errors do
      "#{key} #{message}"
    end

    {:error, errors}
  end
  defp translate(result) do
    result
  end
end
