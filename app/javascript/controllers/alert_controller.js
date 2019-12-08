import { Controller } from 'stimulus'
import { addStylesToElement } from '../src/helpers.js'

// Alert Controller
// Allows element to be hidden/dismissed
export default class extends Controller {
  static targets = [ 'dismiss' ]

  animationStyles = {
    animationDuration: '0.5s',
    animationName: 'fadeout',
    animationIterationCount: '1',
    animationFillMode: 'forwards'
  }

  dismiss() {
    const element = this.dismissTarget;

    // Cannot animate `display: none;`. So set it after animation is done.
    const hideElement = () => { element.style.display = 'none'; };
    element.addEventListener('animationend', hideElement, false);

    // Fire `fadeout` animation
    addStylesToElement(this.animationStyles, element);
  }
}
