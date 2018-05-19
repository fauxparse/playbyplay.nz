# frozen_string_literal: true

When('I choose to add a review') do
  click_link 'Write a review'
end

When('I visit the new review page') do
  visit new_review_path
end

When('I fill in the production name with {string}') do |name|
  fill_in 'review_production_name', with: name
end

When('I click the {string} button') do |button|
  click_button button
end

When('I select yesterday as the performance date') do
  choose 'review[performance_date]',
    option: Time.zone.yesterday.to_s,
    allow_label_click: true
end

When('I write my review') do
  fill_in 'review_text', with: Faker::Hipster.paragraphs(3).join("\n\n")
end

Then('I should be on the new review page') do
  expect(page).to have_current_path(new_review_path)
end

Then('my review should be created') do
  expect(Review).to exist
end

Then('my review should be submitted') do
  expect(Review.last).to be_submitted
end
