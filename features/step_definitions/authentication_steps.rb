# frozen_string_literal: true

Given('I have never logged in') do
  # nothing to do here
end

Given('I am logged in') do
  visit(login_path)
  click_link('Facebook')
  expect(page).to have_selector('.navigation__user')
end

When('I visit the login page') do
  visit(login_path)
end

When('I log in with Facebook') do
  click_link('Facebook')
end

When('I click the logout link') do
  click_link('Log out')
end

Then('I should be taken to the login page') do
  expect(page).to have_current_path(login_path)
end

Then('I should be logged in') do
  expect(page).to have_selector('.navigation__user')
end

Then('I should be logged out') do
  expect(page).not_to have_selector('.navigation__user')
end
