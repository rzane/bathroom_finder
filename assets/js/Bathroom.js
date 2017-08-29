import React from 'react';
import { compose, graphql } from 'react-apollo';
import asEditable from './asEditable';
import EditBathroomForm from './EditBathroomForm';
import { BathroomsQuery, DeleteBathroomMutation } from './queries';

const Bathroom = ({
  handleDelete,
  handleEdit,
  bathroom: {
    label,
    description
  }
}) => (
  <div className='Bathroom card'>
    <header className='card-header'>
      <p className='card-header-title'>
        {label}
      </p>
    </header>

    {description && (
      <div className='card-content'>
        <div className='content'>
          {description}
        </div>
      </div>
    )}

    <footer className='card-footer'>
      <a className='card-footer-item' onClick={handleDelete}>Delete</a>
      <a className='card-footer-item' onClick={handleEdit}>Edit</a>
    </footer>
  </div>
);

const enhance = compose(
  asEditable(EditBathroomForm),
  graphql(DeleteBathroomMutation, {
    props ({ mutate, ownProps: { bathroom } }) {
      return {
        handleDelete (event) {
          event.preventDefault();

          return mutate({
            variables: { id: bathroom.id },
            refetchQueries: [{ query: BathroomsQuery }]
          })
        }
      };
    }
  })
);

export default enhance(Bathroom);
