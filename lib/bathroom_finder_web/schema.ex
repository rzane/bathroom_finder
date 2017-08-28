defmodule BathroomFinderWeb.Schema do
  use Absinthe.Schema

  alias BathroomFinder.{Repo, Bathroom}

  import_types BathroomFinderWeb.Schema.Types

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
      end
    end

    field :delete_bathroom, type: :bathroom do
      arg :id, non_null(:id)

      resolve fn (%{id: id}, _info) ->
        Bathroom
        |> Repo.get!(id)
        |> Repo.delete
      end
    end
  end
end
