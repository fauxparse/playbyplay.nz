# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Submissions, type: :query do
  subject(:query) { Submissions.new(parameters) }

  before do
    create(:submission)
    create(:submission).rejected!
  end

  context 'without parameters' do
    let(:parameters) { {} }
    it { is_expected.to have_exactly(2).items }
  end

  context 'querying by state' do
    let(:parameters) { { state: :pending } }
    it { is_expected.to have_exactly(1).item }
  end
end
