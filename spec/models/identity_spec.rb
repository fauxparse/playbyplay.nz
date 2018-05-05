# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Identity, type: :model do
  subject(:identity) { build(:identity) }

  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }

  describe '#provider' do
    it 'must be a registered Omniauth provider' do
      expect { identity.provider = 'theatreview' }
        .to raise_error(ArgumentError)
    end
  end
end
