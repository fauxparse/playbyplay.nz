import Controller from './review_step_controller'

const KEYS = {
  UP: 38,
  DOWN: 40
}

export default class extends Controller {
  static targets = ['name', 'id', 'autocomplete', 'productions', 'next']

  get name() {
    return this.nameTarget.value
  }

  set name(name) {
    this.nameTarget.value = name
  }

  set id(id) {
    this.idTarget.value = id
  }

  get productions() {
    if (!this._productions) this._productions = []
    return this._productions
  }

  set productions(productions) {
    this._productions = productions
    this.autocompleteTarget.classList.toggle('hidden', !productions.length)
    this.productionsTarget.innerHTML = productions
      .map(this.renderProduction)
      .join('')
    this.index = this.index
  }

  get index() {
    return this._index
  }

  set index(index) {
    const noProductionSelected =
      index === undefined || !this.productions.length
    const selectedRow = this.productionsTarget.querySelector('.selected')
    selectedRow && selectedRow.classList.remove('selected')
    this.nameTarget.classList.toggle('selected', noProductionSelected)

    if (noProductionSelected) {
      this._index = undefined
    } else {
      this._index = (index + this.productions.length) % this.productions.length
      this.productionsTarget
        .querySelectorAll('.review-form__production')
        .item(this.index)
        .classList.add('selected')
    }
  }

  renderProduction({ name, id }) {
    return `<li class="review-form__production">
              <label
                for="review_production_name"
                class="review-form__production-name"
                data-id="${id}"
              >
                ${name}
              </label>
            </li>`
  }

  nameChanged() {
    clearTimeout(this.autocompleteTimeout)
    this.autocompleteTimeout = setTimeout(this.autocompleteProduction, 150)
    this.nextTarget.disabled = !this.name
  }

  keyDown(e) {
    if (e.which === KEYS.UP || e.which === KEYS.DOWN) {
      e.preventDefault()
      const { length } = this.productions

      if (this.index === undefined) {
        this.index = e.which === KEYS.UP ? length - 1 : 0
      } else if (this.index === 0 && e.which === KEYS.UP) {
        this.index = undefined
      } else if (this.index === length - 1 && e.which === KEYS.DOWN) {
        this.index = undefined
      } else {
        this.index += e.which === KEYS.UP ? -1 : 1
      }
    }
  }

  productionClicked(e) {
    const row = e.target.closest('.review-form__production')
    if (row) {
      this.index = Array.from(
        this.productionsTarget.querySelectorAll('.review-form__production')
      ).indexOf(row)
      this.nextTarget.click()
    }
  }

  autocompleteProduction = () => {
    const url = `/productions.json?query=${escape(this.name)}`
    fetch(url, { credentials: 'include' })
      .then(response => response.json())
      .then(({ productions }) => {
        this.productions = productions
      })
  }

  validate() {
    if (this.index === undefined) {
      if (this.name) {
        this.id = ''
      } else {
        this.errors.name = 'Please type something'
      }
    } else {
      this.name = this.productions[this.index].name
      this.id = this.productions[this.index].id
      this.productions = []
    }
  }

  focus() {
    this.nextTarget.disabled = !this.name
    this.nameTarget.focus()
  }
}
