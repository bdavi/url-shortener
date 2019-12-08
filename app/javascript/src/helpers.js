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
  addStylesToElement
};
