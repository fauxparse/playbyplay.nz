import autosize from 'autosize'

import Controller from './review_step_controller'

export default class extends Controller {
  static targets = ['editor']

  connect() {
    autosize(this.editorTarget)
  }

  focus() {
    this.editorTarget.focus()
  }
}
