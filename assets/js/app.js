import React from 'react';
import { render } from 'react-dom';
import 'phoenix_html';

const App = () => (
  <div className='App'>
    <h1>Hello world!</h1>
  </div>
);

render(
  <App />,
  document.getElementById('root')
);
