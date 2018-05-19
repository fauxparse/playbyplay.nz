import { Controller } from 'stimulus'
import isEmpty from 'lodash/isEmpty'

const trueOffsetTop = element =>
  element.offsetTop +
  (element.offsetParent ? trueOffsetTop(element.offsetParent) : 0)

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

  ensureVisible(element) {
    const top = trueOffsetTop(element)
    const height = element.clientHeight
    const scrollable = document.documentElement
    const viewportHeight = window.innerHeight

    if (top < scrollable.scrollTop) {
      scrollable.scrollTop = top
    } else if (top + height - scrollable.scrollTop > viewportHeight) {
      scrollable.scrollTop = top + height - viewportHeight
    }
  }
}
