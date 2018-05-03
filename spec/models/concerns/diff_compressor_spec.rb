# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiffCompressor do
  subject(:compressor) { DiffCompressor.new }

  let(:uncompressed) do
    [
      [['-', 0, 'p'], ['-', 1, 'i']],
      [['-', 3, 'c'], ['+', 1, 'i'], ['+', 2, 'a'], ['+', 3, 'm']],
      [['+', 6, 'e']]
    ]
  end

  let(:compressed) do
    [
      [['-', 0, 'pi']],
      [['-', 3, 'c'], ['+', 1, 'iam']],
      [['+', 6, 'e']]
    ]
  end

  describe '#compress' do
    subject { compressor.compress(uncompressed) }
    it { is_expected.to eq compressed }
  end

  describe '#uncompress' do
    subject { compressor.uncompress(compressed) }
    it { is_expected.to eq uncompressed }
  end
end
