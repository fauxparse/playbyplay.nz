# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Version, type: :model do
  let(:review) { create(:review, :with_multiple_versions) }

  context 'with no changes' do
    subject(:version) { review.versions.build }
    it { is_expected.to be_valid }
  end

  describe '#number' do
    it 'is a list' do
      expect(review.versions.map(&:number)).to eq [1, 2, 3]
    end
  end

  describe '#unpatch' do
    subject(:versioned) { review.versions.last.unpatch(review) }

    it 'shows the correct text' do
      expect(versioned.text).to eq 'Third version'
    end
  end

  describe '#destroy' do
    context 'the first version' do
      before do
        review.versions.first.destroy
        review.reload
      end

      it 'repairs the chain of versions' do
        expect(review.reload.at(review.versions.first).text)
          .to eq 'Second version'
      end

      it 'changes the review’s version number' do
        expect(review.reload.version_number).to eq 3
      end
    end

    context 'the second version' do
      before do
        review.versions.second.destroy
        review.reload
      end

      it 'repairs the chain of versions' do
        expect(review.reload.at(review.versions.first).text)
          .to eq 'First version'
      end

      it 'changes the review’s version number' do
        expect(review.reload.version_number).to eq 3
      end
    end

    context 'the third version' do
      before do
        review.versions.last.destroy
        review.reload
      end

      it 'repairs the chain of versions' do
        expect(review.reload.at(review.versions.first).text)
          .to eq 'First version'
      end

      it 'changes the review’s version number' do
        expect(review.reload.version_number).to eq 3
      end
    end
  end
end
