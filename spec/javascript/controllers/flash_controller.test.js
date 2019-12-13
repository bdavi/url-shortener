import { Application } from 'stimulus';
import FlashController from '../../../app/javascript/controllers/flash_controller.js';

describe("FlashController", () => {
  describe("#dismiss", () => {
    beforeEach(() => {
      document.body.innerHTML = `
        <div data-controller="flash" data-target="flash.dismiss">
          <button data-action="click->flash#dismiss">Close</button>
        </div>
      `;

      const application = Application.start();
      application.register("flash", FlashController);
    });

    it('sets flash animation-name to "fadeout"', () => {
      const flash = document.querySelector('[data-target="flash.dismiss"]');
      const closeButton = document.querySelector('[data-action="click->flash#dismiss"]');

      closeButton.click();
      expect(flash.style['animation-name']).toEqual('fadeout');
    });
  });
});
