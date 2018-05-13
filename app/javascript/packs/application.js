/* eslint no-console:0, import/first:0 */

import 'intersection-observer'
import 'mdn-polyfills/Array.from'
import 'mdn-polyfills/Element.prototype.closest'
import 'promise-polyfill/src/polyfill'
import 'requestidlecallback'
import 'whatwg-fetch'

import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'
import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

Rails.start()
Turbolinks.start()

const application = Application.start()
const context = require.context('../controllers', true, /\.js$/)
application.load(definitionsFromContext(context))
