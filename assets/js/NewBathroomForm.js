import React from 'react';
import { graphql } from 'react-apollo';
import BathroomForm from './BathroomForm';
import {
  BathroomsQuery,
  CreateBathroomMutation
} from './queries';

const enhance = graphql(CreateBathroomMutation, {
  props ({ mutate, ownProps: { setEditing } }) {
    return {
      title: 'Add a bathroom',

      handleSave (attributes) {
        return mutate({
          variables: {
            bathroom: attributes
          },

          update (store, { data: { createBathroom } }) {
            const data = store.readQuery({
              query: BathroomsQuery
            });

            store.writeQuery({
              query: BathroomsQuery,
              data: Object.assign({}, data, {
                bathrooms: data.bathrooms.concat([createBathroom])
              })
            });
          }
        }).then(() => setEditing(false))
          .catch(error => {
            console.error(error);
            alert('Failed to create bathroom!');
          })
      }
    };
  }
});

export default enhance(BathroomForm);
