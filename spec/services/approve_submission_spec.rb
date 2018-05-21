# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApproveSubmission, type: :service do
  subject(:service) { ApproveSubmission.new(submission, moderator) }
  let(:submission) { create(:submission) }
  let(:moderator) { create(:moderator) }

  describe '#call' do
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
end
