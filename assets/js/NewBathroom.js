import React from 'react';
import { compose, withProps } from 'recompose';
import Form from './Form';
import asEditable from './asEditable';

const NewBathroom = ({ handleEdit }) => (
  <button
    onClick={handleEdit}
    className='NewBathroom button is-info is-outlined is-large'
  >
    Add a bathroom
  </button>
);

const NewBathroomForm = withProps(() => ({
  title: 'Add a bathroom'
}))(Form);

export default asEditable(NewBathroomForm)(NewBathroom);
