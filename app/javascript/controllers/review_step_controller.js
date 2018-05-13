import { Controller } from 'stimulus'
import isEmpty from 'lodash/isEmpty'

export default class extends Controller {
  get errors() {
    if (!this._errors) this._errors = {}
    return this._errors
  }

  connect() {
    if (this.element.classList.contains('review-form__section--current')) {
      this.focus()
    }
  }

  validate() {}

  isValid() {
    this._errors = {}
    this.validate()
    return isEmpty(this.errors)
  }

  focus() {}

  blur() {
    const focused = this.element.querySelector(':focus')
    focused && focused.blur()
  }
}
