import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="post-form"
export default class extends Controller {
  static targets = ["selectInput", "newToiForm", "trailer", "location", "label", "input"]

  connect() {
    this.toiNames = Array.from(this.selectInputTarget.options).map(opt => opt.value)
    this.buildSelect()
    this.inputTarget.addEventListener("change", this.updateLabel.bind(this));
  }

  buildSelect() {
    const options = {
      create: this.createEvent.bind(this),
      onChange: this.itemSelected.bind(this),
      render: {
        option_create: function(data, escape) {
          return '<div class="create">Ajouter <strong>' + escape(data.input) + '</strong>&hellip;</div>';
        },
        no_results:function(data,escape){
          return '<div class="no-results">Pas de résultats pour "'+escape(data.input)+'"</div>';
        },
      }
    }
    new TomSelect(this.selectInputTarget, options)
  }

  createEvent(toiName) {
    this.newToiFormTarget.classList.remove('d-none')
    return { value:toiName, text:toiName }
  }

  showInputs(event) {
    if (Array.from(event.currentTarget.options).find(opt => opt.selected).innerText == "Cinema") {
      this.trailerTarget.classList.remove('d-none')
    } else {
      this.trailerTarget.classList.add('d-none')
    }
    if (Array.from(event.currentTarget.options).find(opt => opt.selected).innerText == "Exposition" || Array.from(event.currentTarget.options).find(opt => opt.selected).innerText == "Spectacle") {
      this.locationTarget.classList.remove('d-none')
    } else {
      this.locationTarget.classList.add('d-none')
    }
  }

  showToiInputs(event) {
    if (event.currentTarget.value == "") {
      this.newToiFormTarget.classList.add('d-none')
      return
    }
    const opt = this.toiNames.find(name => name == event.currentTarget.value)
    if (opt) {
      this.newToiFormTarget.classList.add('d-none')
    } else {
      this.newToiFormTarget.classList.remove('d-none')
    }
  }

  updateLabel(event) {
    const fileName = event.target.value.split("\\").pop();
    this.labelTarget.innerHTML = `<i class="fa-solid fa-camera"></i> ${fileName}`;
  }
}
