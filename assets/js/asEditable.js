import {
  branch,
  compose,
  withHandlers,
  withState,
  renderComponent
} from 'recompose';

/***
 * Wraps a component with click handlers to toggle between
 * edit and normal mode.
 */
export default (EditComponent) => compose(
  withState('isEditing', 'setEditing', false),
  withHandlers({
    handleEdit: ({ setEditing }) => (event) => {
      event.preventDefault();
      setEditing(true);
    },

    handleCancel: ({ setEditing }) => (event) => {
      event.preventDefault();
      setEditing(false);
    }
  }),
  branch(
    ({ isEditing }) => isEditing,
    renderComponent(EditComponent)
  )
);
