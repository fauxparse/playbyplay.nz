# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmissionsController, type: :request do
  describe 'GET /submissions' do
    context 'when not logged in' do
      it 'denies access' do
        get submissions_path
        expect(response).to redirect_to login_path
      end
    end

    context 'when logged in as a normal user' do
      let(:user) { create(:user, :facebook) }
      before { log_in_as(user) }

      it 'denies access' do
        expect { get submissions_path }.to raise_error(CanCan::AccessDenied)
      end
    end

    context 'when logged in as a moderator' do
      let(:user) { create(:moderator, :facebook) }
      before { log_in_as(user) }

      it 'allows access' do
        get submissions_path
        expect { get submissions_path }.not_to raise_error
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT /submissions/:id' do
    let(:submission) { create(:submission, review: review) }
    let(:review) { create(:review, production: production) }
    let(:production) { create(:production, name: 'Romeo & Juliet') }
    let(:moderator) { create(:moderator, :facebook) }

    before { log_in_as(moderator) }

    def update
      put submission_path(submission), params: parameters
    end

    context 'to change the name of the production' do
      let(:parameters) do
        {
          submission: {
            review: {
              production: {
                id: production.id,
                name: 'Romeo and Juliet'
              }
            }
          }
        }
      end

      it 'updates the name of the production' do
        expect { update }
          .to change { production.reload.name }
          .from('Romeo & Juliet')
          .to('Romeo and Juliet')
      end

      it 'does not create a new production' do
        production
        expect { update }.not_to change { Production.count }
      end

      context 'when there are multiple reviews' do
        before { create(:review, production: production) }

        it 'does not update the name of the production' do
          expect { update }.not_to change { production.reload.name }
        end

        it 'creates a new production' do
          expect { update }.to change { Production.count }.by(1)
        end

        it 'associates the review with the new production' do
          expect { update }.to change { review.reload.production_id }
        end
      end
    end

    context 'to select a different performance' do
      let(:second_production) { create(:production) }
      let(:parameters) do
        {
          submission: {
            review: {
              production: {
                id: second_production.id,
                name: second_production.name
              }
            }
          }
        }
      end

      it 'updates the review' do
        expect { update }
          .to change { review.reload.production_id }
          .from(production.id)
          .to(second_production.id)
      end
    end
  end

  describe 'PUT /submissions/:id/moderate' do
    def moderate
      put moderate_submission_path(submission), params: params
    end

    let!(:submission) { create(:submission) }
    let(:params) { { submission: { state: state, feedback: feedback } } }
    let(:moderator) { create(:moderator, :facebook) }

    before { log_in_as(moderator) }

    context 'approval' do
      let(:state) { 'approved' }
      let(:feedback) { 'Looks good to me.' }

      it 'approves the submission' do
        expect { moderate }
          .to change { submission.reload.state }
          .from('pending')
          .to('approved')
      end

      it 'publishes the review' do
        expect { moderate }
          .to change { submission.review.reload.state }
          .from('submitted')
          .to('published')
      end

      it 'redirects to the submissions page' do
        moderate
        expect(response).to redirect_to submissions_path
      end

      context 'without feedback' do
        let(:feedback) { '' }

        it 'does not approve the submission' do
          expect { moderate }.not_to change { submission.reload.state }
        end

        it 'does not publish the review' do
          expect { moderate }.not_to change { submission.review.reload.state }
        end

        it 'does not redirect' do
          moderate
          expect(response).not_to redirect_to submissions_path
        end
      end
    end

    context 'request changes' do
      let(:state) { 'changes_requested' }
      let(:feedback) { 'Nearly there.' }

      it 'changes the state of the submission' do
        expect { moderate }
          .to change { submission.reload.state }
          .from('pending')
          .to('changes_requested')
      end

      it 'does not publish the review' do
        expect { moderate }.not_to change { submission.review.reload.state }
      end

      it 'redirects to the submissions page' do
        moderate
        expect(response).to redirect_to submissions_path
      end
    end

    context 'reject' do
      let(:state) { 'rejected' }
      let(:feedback) { 'Uh, no thanks.' }

      it 'changes the state of the submission' do
        expect { moderate }
          .to change { submission.reload.state }
          .from('pending')
          .to('rejected')
      end

      it 'does not publish the review' do
        expect { moderate }.not_to change { submission.review.reload.state }
      end

      it 'redirects to the submissions page' do
        moderate
        expect(response).to redirect_to submissions_path
      end
    end
  end
end
