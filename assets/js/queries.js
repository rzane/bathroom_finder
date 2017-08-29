import { gql } from 'react-apollo';

export const BathroomsQuery = gql`
  query ($coordinates: CoordinatesInput) {
    bathrooms(coordinates: $coordinates) {
      id
      label
      latitude
      longitude
      description
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


