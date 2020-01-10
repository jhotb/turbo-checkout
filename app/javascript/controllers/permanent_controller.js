import { Controller } from "stimulus"

export default class extends Controller {
  static values = {
    append: Boolean,
  }

  cloneChildren(event) {
    const { newBody } = event.data

    const { innerHTML } = newBody.querySelector("#" + this.element.id)

    if (this.appendValue) {
      this.element.insertAdjacentHTML("beforeend", innerHTML)
    } else {
      this.element.innerHTML = innerHTML
    }
  }
}
