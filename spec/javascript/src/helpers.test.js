import { addStylesToElement } from '../../../app/javascript/src/helpers.js'

describe('addStylesToElement', () => {
  it('adds the styles to element.style object', () => {
    const styles = { display: 'none' };
    const element = {
      style: {
        textAlign: 'center'
      }
    };

    addStylesToElement(styles, element);
    expect(element.style.display).toEqual('none');
  });
});
