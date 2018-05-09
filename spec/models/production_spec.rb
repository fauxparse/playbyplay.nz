# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Production, type: :model do
  subject(:production) { build(:production) }

  it { is_expected.to be_valid }

  describe '#slug' do
    subject(:slug) { production.slug }

    before { production.save! }

    it { is_expected.to eq 'romeo-and-juliet' }
  end

  describe '#to_param' do
    subject(:param) { production.to_param }

    before { production.save! }

    it { is_expected.to eq production.slug }
  end
end
