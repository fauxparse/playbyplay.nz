# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewForm do
  subject(:form) { ReviewForm.new(review) }
  let(:reviewer) { create(:reviewer) }

  context 'for a new review' do
    let!(:review) { reviewer.reviews.build }

    it { is_expected.not_to be_valid }

    describe '#update!' do
      subject(:update) do
        form.update(ActionController::Parameters.new(attributes))
      end

      context 'with a new production' do
        let(:attributes) do
          {
            production: attributes_for(:production),
            performance_date: Date.yesterday,
            text: Faker::Hipster.sentence
          }
        end

        it 'creates a review' do
          expect { update }.to change(Review, :count).by(1)
        end

        it 'does not creates a new production' do
          expect { update }.to change(Production, :count).by(1)
        end
      end

      context 'with an existing production' do
        let!(:production) { create(:production) }
        let(:attributes) do
          {
            production: { id: production.id },
            performance_date: Date.yesterday,
            text: Faker::Hipster.sentence
          }
        end

        it 'creates a review' do
          expect { update }.to change(Review, :count).by(1)
        end

        it 'does not creates a new production' do
          expect { update }.not_to change(Production, :count)
        end

        it 'is linked to the correct production' do
          update
          expect(review.production).to eq production
        end
      end

      context 'with invalid attributes' do
        let(:attributes) { {} }

        it { is_expected.to be_falsy }

        it 'does not creates a new review' do
          expect { update }.not_to change(Review, :count)
        end

        it 'populates errors' do
          update
          expect(form).to have_exactly(1).error_on(:text)
          expect(form).to have_exactly(1).error_on(:production)
          expect(form).to have_exactly(1).error_on(:performance_date)
        end
      end
    end
  end
end
