import React from 'react';
import { graphql } from 'react-apollo';
import { BathroomsQuery } from './queries';
import Bathroom from './Bathroom';
import NewBathroom from './NewBathroom';

const BathroomFinder = ({ data: { bathrooms, loading } }) => (
  <div className='App'>
    <section className='hero is-info is-bold is-medium'>
      <div className='hero-body'>
        <div className='container has-text-centered'>
          <h1 className='title'>
            Bathroom Finder
          </h1>
          <h2 className='subtitle'>
            Because sometimes, you really need to go.
          </h2>
        </div>
      </div>
    </section>

    <section className='section'>
      <div className='container'>
        {loading ? (
          <p className='subtitle has-text-centered'>
            Loading bathrooms...
          </p>
        ) : bathrooms.map(bathroom =>
          <Bathroom key={bathroom.id} bathroom={bathroom} />
        )}

        <NewBathroom />
      </div>
    </section>
  </div>
);

export default graphql(BathroomsQuery)(BathroomFinder);
