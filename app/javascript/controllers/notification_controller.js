import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    setTimeout(() => {
      let alert = document.getElementById('notification');
      alert.remove();
    }, 2000);
  }
}
