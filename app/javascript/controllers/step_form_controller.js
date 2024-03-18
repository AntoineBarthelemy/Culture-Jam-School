import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "step1", "step2", "nextButton","spinner"]

  connect() {
    this.showStep(this.step1Target)
  }

  next() {
    event.preventDefault()
    this.hideStep(this.step1Target)
    this.showStep(this.step2Target)
  }

  hideStep(step) {
    step.classList.add('fade-out')
    step.classList.add('d-none')
    step.classList.remove('fade-out')
  }

  showStep(step) {
    step.classList.remove('d-none')
    step.classList.add('fade-in')
  }
}
