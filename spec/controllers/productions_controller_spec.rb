# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductionsController, type: :request do
  describe 'GET /productions' do
    subject { response }
    let(:json) do
      ActiveSupport::JSON.decode(response.body).deep_symbolize_keys
    end

    before do
      create(:production, name: 'Comedy of Errors')
      create(:production, name: 'Romeo and Juliet')
      get productions_path, params: params.merge(format: :json)
    end

    context 'with no query' do
      let(:params) { {} }

      it { is_expected.to be_successful }

      it 'returns no productions' do
        expect(json[:productions]).to be_empty
      end
    end

    context 'with a query' do
      let(:params) { { query: 'rom' } }

      it { is_expected.to be_successful }

      it 'returns a single production' do
        expect(json[:productions]).to have_exactly(1).item
      end
    end
  end
end
