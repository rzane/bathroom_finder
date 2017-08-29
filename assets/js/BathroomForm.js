import React from 'react';
import Geosuggest from 'react-geosuggest';
import { graphql } from 'react-apollo';
import { compose, withHandlers, withStateHandlers } from 'recompose';
import { CategoriesQuery } from './queries';

const BathroomForm = ({
  title,
  values,
  data: { categories = [] },
  handleSave,
  handleCancel,
  handleChange,
  handleLocationChange
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
            <Geosuggest
              initialValue={values.label}
              onSuggestSelect={handleLocationChange}
            />
          </div>
        </div>

        <div className='field'>
          <div className='control'>
            <select
              name='category_id'
              className='input'
              value={values.category_id}
              onChange={handleChange}
            >
              {categories.map(category =>
                <option value={category.id} key={category.id}>
                  {category.name}
                </option>
              )}
            </select>
          </div>
        </div>

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
  graphql(CategoriesQuery),

  withStateHandlers(
    ({ bathroom = {} }) => ({
      values: {
        label: bathroom.label,
        latitude: bathroom.latitude,
        longitude: bathroom.longitude,
        description: bathroom.description || '',
        category_id: bathroom.category_id || '',
      }
    }),
    {
      handleChange: ({ values }) => (event) => ({
        values: Object.assign({}, values, {
          [event.target.name]: event.target.value
        })
      }),

      handleLocationChange: ({ values }) => ({ label, location: { lat, lng } }) => ({
        values: Object.assign({}, values, {
          label,
          latitude: lat,
          longitude: lng
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
