# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  subject(:review) { build(:review) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:text) }

  describe '#save' do
    context 'when called for the first time' do
      it 'does not create a version' do
        expect { review.save }.not_to change(Version, :count)
      end
    end

    context 'when text is changed' do
      subject(:review) { create(:review, text: 'First version') }

      it 'creates a version' do
        expect { review.update!(text: 'Second version') }
          .to change { review.versions.count }
          .by(1)
      end
    end

    context 'when text is unchanged' do
      subject(:review) { create(:review) }

      it 'does not create a version' do
        expect { review.save! }.not_to change { review.versions.count }
      end
    end
  end

  describe '#at' do
    before { Timecop.scale(3600) }
    after { Timecop.scale(1) }

    subject(:versioned) { review.at(review.versions.first) }
    let(:review) do
      create(:review, text: 'First version').tap do |review|
        review.update!(text: 'Second version')
        review.update!(text: 'Third version')
      end
    end

    it 'has the correct text' do
      expect(versioned.text).to eq 'First version'
    end

    it 'has the correct version number' do
      expect(versioned.version_number).to eq 1
    end

    it 'is frozen' do
      expect(versioned).to be_frozen
    end

    it 'has the correct updated_at time' do
      expect(review.created_at).to be < review.updated_at
      expect(versioned.updated_at.to_i).to eq review.created_at.to_i
    end
  end
end
