import { Controller } from 'stimulus'
import autosize from 'autosize'

export default class extends Controller {
  static targets = ['step', 'progress', 'slider']

  connect() {
    autosize(this.element.querySelectorAll('textarea'))
    this.index = this.index || 0
  }

  get index() {
    return parseInt(this.data.get('index') || '0')
  }

  set index(index) {
    this.data.set('index', index)
    this.stepTargets[index].classList.add('review-form__section--current')
    const current = this.element.querySelector('.review-step--current')
    current && current.classList.remove('review-step--current')
    this.progressTargets[index].classList.add('review-step--current')
    this.sliderTarget.style.transform = `translateX(${index * -100}%)`
  }

  submit(e) {
    e.preventDefault()
    this.index += 1
  }
}
