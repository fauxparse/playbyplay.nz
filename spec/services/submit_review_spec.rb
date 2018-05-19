# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubmitReview, type: :service do
  subject(:service) { SubmitReview.new(review) }
  let(:review) { create(:review) }

  describe '#call' do
    it 'creates a pending submission' do
      expect { service.call }.to change { Submission.pending.count }.by 1
      expect(review.submissions).to exist
    end

    it 'changes the state of the review' do
      expect { service.call }
        .to change { review.state }
        .from('draft')
        .to('submitted')
    end
  end
end
