/* eslint no-console:0, import/first:0 */

import 'es6-shim'
import 'mdn-polyfills/Element.prototype.closest'
import 'promise-polyfill/src/polyfill'
import 'requestidlecallback'
import 'weakmap-polyfill'
import 'whatwg-fetch'
import 'intersection-observer'

import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'
import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

Rails.start()
Turbolinks.start()

const application = Application.start()
const context = require.context('../controllers', true, /\.js$/)
application.load(definitionsFromContext(context))
