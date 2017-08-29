import React from 'react';
import { compose, graphql } from 'react-apollo';
import BathroomForm from './BathroomForm';
import { UpdateBathroomMutation } from './queries';

const enhance =  graphql(UpdateBathroomMutation, {
  props ({ mutate, ownProps: { bathroom, setEditing } }) {
    return {
      title: `Editing '${bathroom.label}'`,

      handleSave (attributes) {
        return mutate({
          variables: {
            id: bathroom.id,
            bathroom: attributes
          }
        }).then(() => setEditing(false))
          .catch((error) => {
            console.error(error);
            alert('Failed to update bathroom!');
          });
      }
    };
  }
});

export default enhance(BathroomForm);
