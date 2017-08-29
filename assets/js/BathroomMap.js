import React from 'react';
import { compose, withProps } from 'recompose';
import { withGoogleMap, GoogleMap, Marker } from 'react-google-maps';

const BathroomMap = ({ position }) => (
  <GoogleMap defaultZoom={16} defaultCenter={position}>
    <Marker position={position} />
  </GoogleMap>
);

const enhance = compose(
  withProps(() => ({
    containerElement: <div className='BathroomMap' />,
    mapElement: <div style={{ height: '100%' }} />
  })),

  withGoogleMap
);

export default enhance(BathroomMap);
