import { Application } from 'stimulus';
import AlertController from '../../../app/javascript/controllers/alert_controller.js';

describe("AlertController", () => {
  describe("#dismiss", () => {
    beforeEach(() => {
      document.body.innerHTML = `
        <div id="alert" data-controller="alert" data-target="alert.dismiss">
          <button id="close-button" data-action="click->alert#dismiss">Close</button>
        </div>
      `;

      const application = Application.start();
      application.register("alert", AlertController);
    });

    it('sets alert animation-name to "fadeout"', () => {
      const alert = document.querySelectorAll('[data-target="alert.dismiss"]').item(0)
      const closeButton = document.querySelectorAll('[data-action="click->alert#dismiss"]').item(0)

      closeButton.click();
      expect(alert.style['animation-name']).toEqual('fadeout');
    });
  });
});
