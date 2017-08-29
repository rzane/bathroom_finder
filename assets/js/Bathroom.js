import React from 'react';
import { withProps } from 'recompose';
import Form from './Form';
import asEditable from './asEditable';

const Bathroom = ({
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
      <a className='card-footer-item'>Delete</a>
      <a className='card-footer-item' onClick={handleEdit}>Edit</a>
    </footer>
  </div>
);

const EditBathroom = withProps(() => ({
  title: 'Edit bathroom'
}))(Form);

export default asEditable(EditBathroom)(Bathroom);
