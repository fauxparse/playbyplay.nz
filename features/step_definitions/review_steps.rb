# frozen_string_literal: true

When('I choose to add a review') do
  click_link 'Write a review'
end

Then('I should be on the new review page') do
  expect(page).to have_current_path(new_review_path)
end
