# frozen_string_literal: true

Given('I have never logged in') do
  # nothing to do here
end

Then('I should be taken to the login page') do
  expect(page).to have_current_path(login_path)
end

When('I log in with Facebook') do
  click_link('Facebook')
end
