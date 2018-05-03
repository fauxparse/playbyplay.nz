# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  subject(:review) { build(:review) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:text) }
end
