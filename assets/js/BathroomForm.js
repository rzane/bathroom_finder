import React from 'react';
import {
  compose,
  withHandlers,
  withStateHandlers
} from 'recompose';

const BathroomForm = ({
  title,
  values,
  handleSave,
  handleChange,
  handleCancel
}) => (
  <div className='BathroomForm card'>
    <header className='card-header'>
      <p className='card-header-title'>
        {title}
      </p>
    </header>

    <div className='card-content'>
      <div className='content'>

        <div className='field'>
          <div className='control'>
            <textarea
              name='description'
              className='input'
              placeholder='Enter a description'
              value={values.description}
              onChange={handleChange}
            />
          </div>
        </div>

      </div>
    </div>

    <footer className='card-footer'>
      <a className='card-footer-item' onClick={handleCancel}>Cancel</a>
      <a className='card-footer-item' onClick={handleSave}>Save</a>
    </footer>
  </div>
);

const enhance = compose(
  withStateHandlers(
    ({ bathroom = {} }) => ({
      values: {
        description: bathroom.description || ''
      }
    }),
    {
      handleChange: ({ values }) => (event) => ({
        values: Object.assign({}, values, {
          [event.target.name]: event.target.value
        })
      })
    }
  ),

  withHandlers({
    handleSave: ({ handleSave, values }) => (event) => {
      event.preventDefault();
      handleSave(values);
    }
  })
);

export default enhance(BathroomForm);
