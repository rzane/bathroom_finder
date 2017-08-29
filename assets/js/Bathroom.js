import React from 'react';
import { graphql } from 'react-apollo';
import { compose, withProps } from 'recompose';
import Form from './Form';
import asEditable from './asEditable';
import {
  BathroomsQuery,
  DeleteBathroomMutation
} from './queries';

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

const EditBathroom = withProps(() => ({
  title: 'Edit bathroom'
}))(Form);

const enhance = compose(
  asEditable(EditBathroom),
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
