import { gql } from 'react-apollo';

export const BathroomsQuery = gql`
  query ($coordinates: CoordinatesInput) {
    bathrooms(coordinates: $coordinates) {
      id
      label
      latitude
      longitude
      description
      category_id
      category {
        name
      }
    }
  }
`;

export const CategoriesQuery = gql`
  query {
    categories {
      id
      name
    }
  }
`;

export const CreateBathroomMutation = gql`
  mutation ($bathroom: BathroomInput) {
    createBathroom(bathroom: $bathroom) {
      id
      label
      latitude
      longitude
      description
      category_id
      category {
        name
      }
    }
  }
`;

export const UpdateBathroomMutation = gql`
  mutation ($id: ID, $bathroom: BathroomInput) {
    updateBathroom(id: $id, bathroom: $bathroom) {
      id
      label
      latitude
      longitude
      description
      category_id
      category {
        name
      }
    }
  }
`;

export const DeleteBathroomMutation = gql`
  mutation ($id: ID) {
    deleteBathroom(id: $id) {
      id
    }
  }
`;
