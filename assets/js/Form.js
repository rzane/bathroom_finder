import React from 'react';

const Form = ({ title, handleCancel }) => (
  <div className='Form card'>
    <header className='card-header'>
      <p className='card-header-title'>
        {title}
      </p>
    </header>

    <div className='card-content'>
      <div className='content'>

        <div className='field'>
          <div className='control'>
            <textarea className='input' placeholder='Enter a description'>
            </textarea>
          </div>
        </div>

      </div>
    </div>

    <footer className='card-footer'>
      <a className='card-footer-item' onClick={handleCancel}>Cancel</a>
      <a className='card-footer-item'>Save</a>
    </footer>
  </div>
);

export default Form;
