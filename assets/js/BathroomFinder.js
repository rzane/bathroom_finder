import React from 'react';
import { graphql } from 'react-apollo';
import { BathroomsQuery } from './queries';
import Bathroom from './Bathroom';
import NewBathroomButton from './NewBathroomButton';
import CoordinateSearch from './CoordinateSearch';

const BathroomFinder = ({ data: { bathrooms, loading, refetch, variables } }) => (
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
        <CoordinateSearch onChange={refetch} />

        {loading ? (
          <p className='subtitle has-text-centered'>
            Loading bathrooms...
          </p>
        ) : bathrooms.map(bathroom =>
          <Bathroom key={bathroom.id} bathroom={bathroom} variables={variables} />
        )}
      </div>
    </section>

    <section className='section'>
      <div className='container'>
        <NewBathroomButton variables={variables} />
      </div>
    </section>
  </div>
);

export default graphql(BathroomsQuery)(BathroomFinder);
