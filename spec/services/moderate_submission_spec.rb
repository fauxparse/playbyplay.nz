# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModerateSubmission, type: :service do
  subject(:service) do
    ModerateSubmission.new(submission, moderator, parameters)
  end
  let(:submission) { create(:submission) }
  let(:moderator) { create(:moderator) }

  describe '#call' do
    context 'with valid parameters' do
      let(:parameters) do
        ActionController::Parameters.new(
          state: 'approved',
          feedback: 'Good job, pal!'
        )
      end

      it 'assigns a moderator to the submission' do
        expect { service.call }
          .to change { submission.moderator }
          .from(nil)
          .to(moderator)
      end

      it 'approves the submission' do
        expect { service.call }
          .to change { submission.state }
          .from('pending')
          .to('approved')
      end

      it 'publishes the review' do
        expect { service.call }
          .to change { submission.review.state }
          .to('published')
      end
    end

    context 'with no feedback' do
      let(:parameters) do
        ActionController::Parameters.new(state: 'rejected')
      end

      it 'does not reject the submission' do
        expect { service.call }.not_to change { submission.state }
      end
    end
  end
end
