# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Submission, type: :model do
  subject(:submission) { build(:submission) }

  it { is_expected.to be_valid }
  it { is_expected.to be_pending }

  describe '#version_number' do
    subject(:version_number) { submission.version_number }
    it { is_expected.to eq submission.review.version_number }
  end
end
