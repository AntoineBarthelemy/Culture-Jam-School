import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="read-notifications"
export default class extends Controller {
  static values = { path: String }

  connect() {
    this.element.addEventListener('hidden.bs.dropdown', () => {
      this.element.outerHTML = this.notifHtml
    })
  }

  read(event) {
    fetch(this.pathValue, {
      method: "PATCH",
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
      }
    })
      .then(response => response.json())
      .then(data => {
        this.notifHtml = data.html;
      });
  }
}
