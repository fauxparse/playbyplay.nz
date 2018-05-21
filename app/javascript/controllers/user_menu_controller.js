import { Controller } from 'stimulus'
import Drop from 'tether-drop'

export default class extends Controller {
  static targets = ['link', 'menu']

  connect() {
    this.drop = new Drop({
      target: this.linkTarget,
      content: this.menuTarget.cloneNode(true),
      classes: 'navigation__dropdown',
      tetherOptions: {
        attachment: 'top right',
        targetAttachment: 'bottom right'
      }
    })
  }
}
