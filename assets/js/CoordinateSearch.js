import React from 'react';
import Geosuggest from 'react-geosuggest';
import { withHandlers } from 'recompose';

const CoordinateSearch = (props) => (
  <div className='CoordinateSearch'>
    <Geosuggest {...props} />
  </div>
)

const enhance = withHandlers({
  onSuggestSelect: ({ onChange }) => ({ location: { lat, lng } }) => {
    onChange({
      coordinates: {
        latitude: lat,
        longitude: lng
      }
    });
  }
});

export default enhance(CoordinateSearch);
