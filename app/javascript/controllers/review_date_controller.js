import Controller from './review_step_controller'

export default class extends Controller {
  static targets = ['date']

  get date() {
    return this.selectedRadioButton().value
  }

  focus() {
    const current = this.selectedRadioButton()
    current && current.focus()
  }

  selectedRadioButton() {
    return this.element.querySelector(':checked')
  }

  validate() {
    console.log(this.date)
  }
}
