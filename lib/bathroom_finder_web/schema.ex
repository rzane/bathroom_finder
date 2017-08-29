defmodule BathroomFinderWeb.Schema do
  use Absinthe.Schema

  alias BathroomFinder.{Repo, Bathroom}
  alias BathroomFinderWeb.Schema

  import_types BathroomFinderWeb.Schema.Types

  def translate({:error, %Ecto.Changeset{} = changeset}) do
    errors = for {key, {message, _}} <- changeset.errors do
      "#{key} #{message}"
    end

    {:error, errors}
  end
  def translate(result) do
    result
  end

  query do
    field :bathrooms, list_of(:bathroom) do
      resolve fn (_args, _info) ->
        {:ok, Repo.all(Bathroom)}
      end
    end

    field :bathroom, :bathroom do
      arg :id, non_null(:id)

      resolve fn (%{id: id}, _info) ->
        {:ok, Repo.get(Bathroom, id)}
      end
    end
  end

  mutation do
    field :create_bathroom, type: :bathroom do
      arg :bathroom, non_null(:bathroom_input)

      resolve fn (%{bathroom: input}, _info) ->
        %Bathroom{}
        |> Bathroom.changeset(input)
        |> Repo.insert
        |> Schema.translate
      end
    end

    field :update_bathroom, type: :bathroom do
      arg :id, non_null(:id)
      arg :bathroom, non_null(:bathroom_input)

      resolve fn (%{id: id, bathroom: input}, _info) ->
        Bathroom
        |> Repo.get!(id)
        |> Bathroom.changeset(input)
        |> Repo.update
        |> Schema.translate
      end
    end

    field :delete_bathroom, type: :bathroom do
      arg :id, non_null(:id)

      resolve fn (%{id: id}, _info) ->
        Bathroom
        |> Repo.get!(id)
        |> Repo.delete
        |> Schema.translate
      end
    end
  end
end
