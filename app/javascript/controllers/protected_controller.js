import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = { refreshInterval: Number };

  connect() {
    this.onLoad();

    if (this.hasRefreshIntervalValue) {
      this.startRefreshing();
    }
  }

  disconnect() {
    this.stopRefreshing();
  }

  onLoad() {
    const viewer = document.querySelector('meta[name="user-id"]').content;
    const protected_links = document.getElementsByClassName('protected-links');

    for (let i = 0; i < protected_links.length; i++) {
      const link = protected_links[i];

      if (viewer === link.getAttribute('data-user-id')) {
        link.classList.remove('d-none');
      }
    }
  }

  startRefreshing() {
    this.refreshTimer = setInterval(() => {
      this.onLoad();
    }, this.refreshIntervalValue);
  }

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer);
    }
  }
}
