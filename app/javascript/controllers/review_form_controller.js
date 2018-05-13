import { Controller } from 'stimulus'
import autosize from 'autosize'

const CURRENT_SECTION = 'review-form__section--current'
const CURRENT_STEP = 'review-form__step--current'

export default class extends Controller {
  static targets = ['step', 'section', 'slider']

  connect() {
    autosize(this.element.querySelectorAll('textarea'))
    this.index = this.index || 0
  }

  get index() {
    return parseInt(this.data.get('index') || '0', 10)
  }

  set index(index) {
    this.data.set('index', index)
    this.currentSection = index
    this.currentStep = index
    this.sliderTarget.style.transform = `translateX(${index * -100}vw)`
  }

  set currentSection(index) {
    this.currentSection && this.currentSection.blur()
    this.setCurrentElement(this.sectionTargets, index, CURRENT_SECTION)
    const controller = this.currentStepController
    controller && controller.focus()
  }

  get currentSection() {
    return this.sectionTargets[this.index]
  }

  set currentStep(index) {
    this.setCurrentElement(this.stepTargets, index, CURRENT_STEP)
  }

  get currentStepController() {
    const section = this.currentSection
    return this.application.getControllerForElementAndIdentifier(
      section,
      section.getAttribute('data-controller')
    )
  }

  submit(e) {
    if (this.index < this.sectionTargets.length - 1) {
      this.next(e)
    } else if (!this.currentStepController.isValid()) {
      e.preventDefault()
    }
  }

  next(e) {
    e && e.preventDefault()
    if (this.currentStepController.isValid()) {
      this.index += 1
    }
  }

  back(e) {
    e && e.preventDefault()
    this.index -= 1
  }

  setCurrentElement(collection, index, className) {
    const current = this.element.querySelector(`.${className}`)
    const newcomer = collection[index]
    current && current.classList.remove(className)
    newcomer && newcomer.classList.add(className)
    return newcomer
  }
}
