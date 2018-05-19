# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }

  describe '#to_s' do
    subject(:to_s) { user.to_s }
    it { is_expected.to eq user.name }
  end
end
