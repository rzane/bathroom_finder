import React from 'react';
import { compose, withProps } from 'recompose';
import BathroomForm from './BathroomForm';

const enhance =  withProps(() => ({
  title: 'Edit bathroom'
}));

export default enhance(BathroomForm);
