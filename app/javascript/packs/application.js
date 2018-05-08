/* eslint no-console:0, import/first:0 */

require('intersection-observer')

import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'
import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

Rails.start()
Turbolinks.start()

const application = Application.start()
const context = require.context('../controllers', true, /\.js$/)
application.load(definitionsFromContext(context))
