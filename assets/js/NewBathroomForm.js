import React from 'react';
import { withProps } from 'recompose';
import BathroomForm from './BathroomForm';

const enhance = withProps(() => ({
  title: 'Add a bathroom'
}));

export default enhance(BathroomForm);
