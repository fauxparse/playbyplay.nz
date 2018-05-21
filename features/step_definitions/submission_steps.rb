# frozen_string_literal: true

Given('there is a pending submission') do
  @review = create(:review)
  @submission = create(:submission, review: @review)
end

When('I visit the submissions page') do
  visit(submissions_path)
end

When('I click on the submission') do
  click_on(@review.production.name)
end

When('I fill in my feedback') do
  fill_in('submission_feedback', with: Faker::Hipster.paragraph)
end

Then('I should be on the submissions page') do
  expect(page).to have_current_path(submissions_path)
end

Then('I should see confirmation that the submission was approved') do
  expect(page).to have_content 'was approved'
end

Then('I should not see the submission') do
  within('.submissions') do
    expect(page).not_to have_content @review.production.name
  end
end

Then('the review should be published') do
  expect(@review.reload).to be_published
end
