import { Controller } from 'stimulus'
import { tween } from 'popmotion'
import scroll from 'stylefire/scroll'

import 'mdn-polyfills/Array.from'
import 'mdn-polyfills/Element.prototype.closest'

export default class extends Controller {
  connect() {
    this.observer = new IntersectionObserver(this.scrolled, {
      threshold: [0.95, 0.96, 0.97, 0.98, 0.99, 1]
    })
    Array.from(this.element.querySelectorAll('.review-form__section'))
      .forEach(section => this.observer.observe(section))
  }

  disconnect() {
    this.observer.disconnect()
  }

  scrolled = entries => {
    entries.forEach(entry =>
      entry.target.classList.toggle(
        'review-form__section--fixed',
        entry.boundingClientRect.y < 0
      )
    )
  }

  scrollTo(e) {
    e.preventDefault()
    const target = e.target.closest('a').getAttribute('href')
    const targetElement = document.querySelector(target)
    if (targetElement) {
      const parent = document.documentElement
      tween({
        from: parent.scrollTop,
        to: targetElement.offsetTop - 1,
        duration: Math.abs(parent.scrollTop - targetElement.offsetTop)
      }).start(scroll().set('top'))
    }
  }
}
