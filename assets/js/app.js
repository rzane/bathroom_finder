import React from 'react';
import { render } from 'react-dom';
import { ApolloClient, ApolloProvider } from 'react-apollo';
import BathroomFinder from './BathroomFinder';
import '../css/app.scss';

const client = new ApolloClient();

render(
  <ApolloProvider client={client}>
    <BathroomFinder />
  </ApolloProvider>,
  document.getElementById('root')
);
