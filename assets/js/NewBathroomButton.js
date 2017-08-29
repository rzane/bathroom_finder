import React from 'react';
import { compose, withProps } from 'recompose';
import asEditable from './asEditable';
import NewBathroomForm from './NewBathroomForm';

const NewBathroomButton = ({ handleEdit }) => (
  <button
    onClick={handleEdit}
    className='NewBathroomButton button is-info is-outlined is-large'
  >
    Add a bathroom
  </button>
);

export default asEditable(NewBathroomForm)(NewBathroomButton);
