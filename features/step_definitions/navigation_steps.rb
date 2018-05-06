# frozen_string_literal: true

When('I visit the home page') do
  visit root_path
end

Then('I should be on the home page') do
  expect(page).to have_current_path(root_path)
end
