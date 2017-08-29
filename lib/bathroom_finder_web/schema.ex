defmodule BathroomFinderWeb.Schema do
  use Absinthe.Schema
  alias BathroomFinderWeb.Schema.Resolver

  import_types BathroomFinderWeb.Schema.Types

  query do
    field :bathrooms, list_of(:bathroom) do
      arg :coordinates, :coordinates_input
      resolve &Resolver.all/2
    end

    field :bathroom, :bathroom do
      arg :id, non_null(:id)
      resolve &Resolver.find/2
    end

    field :categories, list_of(:category) do
      resolve &Resolver.categories/2
    end
  end

  mutation do
    field :create_bathroom, type: :bathroom do
      arg :bathroom, non_null(:bathroom_input)
      resolve &Resolver.create/2
    end

    field :update_bathroom, type: :bathroom do
      arg :id, non_null(:id)
      arg :bathroom, non_null(:bathroom_input)
      resolve &Resolver.update/2
    end

    field :delete_bathroom, type: :bathroom do
      arg :id, non_null(:id)
      resolve &Resolver.delete/2
    end
  end
end
