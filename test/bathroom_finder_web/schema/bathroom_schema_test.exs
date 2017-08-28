defmodule BathroomFinderWeb.BathroomSchemaTest do
  use BathroomFinderWeb.ConnCase
  alias BathroomFinder.{Bathroom, Repo}

  @attributes %{
    "label": "Foo",
    "latitude": 1.7,
    "longitude": 1.7
  }

  @bathroom """
  query ($id: ID) {
    bathroom(id: $id) {
      id
    }
  }
  """

  @bathrooms """
  query {
    bathrooms {
      id
    }
  }
  """

  @create_bathroom """
  mutation ($bathroom: BathroomInput) {
    createBathroom(bathroom: $bathroom) {
      id
    }
  }
  """

  @update_bathroom """
  mutation ($id: ID, $bathroom: BathroomInput) {
    updateBathroom(id: $id, bathroom: $bathroom) {
      id
      label
    }
  }
  """

  @delete_bathroom """
  mutation ($id: ID) {
    deleteBathroom(id: $id) {
      id
    }
  }
  """

  defp insert(:bathroom) do
    %Bathroom{}
    |> Bathroom.changeset(@attributes)
    |> Repo.insert!
  end

  def graphql(conn, query, variables \\ %{}) do
    payload = %{
      "query" => query,
      "variables" => Poison.encode!(variables)
    }

    post(conn, "/graphql", payload) |> json_response(200)
  end

  test "bathrooms", %{conn: conn} do
    bathroom  = insert(:bathroom)
    response  = graphql(conn, @bathrooms)
    bathrooms = response["data"]["bathrooms"]
    assert List.first(bathrooms)["id"] == to_string(bathroom.id)
  end

  test "bathroom", %{conn: conn} do
    bathroom = insert(:bathroom)
    response = graphql(conn, @bathroom, %{id: bathroom.id})
    assert response["data"]["bathroom"]["id"] == to_string(bathroom.id)
  end

  test "createBathroom", %{conn: conn} do
    response = graphql(conn, @create_bathroom, %{bathroom: @attributes})
    assert response["data"]["createBathroom"]["id"]
  end

  test "updateBathroom", %{conn: conn} do
    bathroom = insert(:bathroom)

    payload = %{
      id: bathroom.id,
      bathroom: %{label: "Updated"}
    }

    response = graphql(conn, @update_bathroom, payload)
    assert response["data"]["updateBathroom"]["label"] == "Updated"
  end

  test "deleteBathroom", %{conn: conn} do
    bathroom = insert(:bathroom)
    response = graphql(conn, @delete_bathroom, %{id: bathroom.id})
    assert response["data"]["deleteBathroom"]["id"] == to_string(bathroom.id)
  end
end
