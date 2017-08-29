import { gql } from 'react-apollo';

export const BathroomsQuery = gql`
  query {
    bathrooms {
      id
      label
      latitude
      longitude
      description
    }
  }
`;

export const CreateBathroomQuery = gql`
  mutation ($bathroom: BathroomInput) {
    createBathroom(bathroom: $bathroom) {
      id
      label
      latitude
      longitude
      description
    }
  }
`;

export const UpdateBathroomQuery = gql`
  mutation ($id: ID, $bathroom: BathroomInput) {
    updateBathroom(id: $id, bathroom: $bathroom) {
      id
      label
      latitude
      longitude
      description
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


