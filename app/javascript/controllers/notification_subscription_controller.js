import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="notification-subscription"
export default class extends Controller {
  static values = { userId: Number }
  static targets = ["notifContainer", "cpt", "noNotif"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationChannel", id: this.userIdIdValue },
      {
        received: (data) => {
          this.notifContainerTarget.insertAdjacentHTML("afterbegin", data)
          this.cptTarget.innerText = parseInt(this.cptTarget.innerText) + 1
          this.cptTarget.classList.remove('d-none')

          this.noNotifTarget.classList.add('d-none')

          this.cptTarget.classList.add("cpt-notif-animate");
          setTimeout(() => {
            this.cptTarget.classList.remove("cpt-notif-animate");
          }, 1000);
        }
      }
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }
}
