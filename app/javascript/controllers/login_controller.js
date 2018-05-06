import { Controller } from 'stimulus'

export default class extends Controller {
  show(e) {
    if (this.canLogIn()) {
      e.preventDefault()
      e.stopPropagation()
      this.rewriteURLs(e.target)
      this.showLoginForm()
    }
  }

  hide(e) {
    if (this.pageContent.classList.contains('page-content--hidden')) {
      e.preventDefault()
      e.stopPropagation()
      this.hideLoginForm()
    }
  }

  get pageContent() {
    if (this._pageContent) return this._pageContent
    return (this._pageContent = document.querySelector('.page-content'))
  }

  get loginForm() {
    if (this._loginForm) return this._loginForm
    return (this._loginForm = document.querySelector('.login'))
  }

  canLogIn() {
    return this.pageContent && this.loginForm
  }

  showLoginForm() {
    this.pageContent.classList.add('page-content--hidden')
  }

  hideLoginForm() {
    this.pageContent.classList.remove('page-content--hidden')
  }

  rewriteURLs(target) {
    const redirect = `?redirect=${target.getAttribute('href')}`
    Array.from(document.querySelectorAll('.login__provider')).forEach(link =>
      link.setAttribute('href', link.href.replace(/(\?.*)?$/, redirect))
    )
  }
}
