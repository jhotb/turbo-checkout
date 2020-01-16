import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [
    "input",
  ]

  stepUp() {
    this.inputTarget.stepUp()
  }

  stepDown() {
    this.inputTarget.stepDown()
  }
}
