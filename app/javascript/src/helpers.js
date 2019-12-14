// ############################################################################
// General use helpers
// ############################################################################

// Add a hash of CSS styles to an element
const addStylesToElement = (styles, element) => {
  Object.assign(element.style, styles);
};

// ############################################################################
// Module Exports
// ############################################################################

export {
  /* eslint-disable-next-line import/prefer-default-export */
  addStylesToElement,
};
