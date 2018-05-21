# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Submissions, type: :query do
  subject(:query) { Submissions.new(parameters) }
  let!(:pending) { create(:submission) }
  let!(:rejected) { create(:submission).tap(&:rejected!) }

  context 'without parameters' do
    let(:parameters) { {} }

    it 'defaults to pending' do
      expect(query).to have_exactly(1).item
      expect(query).to include(pending)
      expect(query).not_to include(rejected)
    end
  end

  context 'querying by state' do
    let(:parameters) { { state: :rejected } }

    it 'only includes rejected submissions' do
      expect(query).to have_exactly(1).item
      expect(query).not_to include(pending)
      expect(query).to include(rejected)
    end
  end
end
