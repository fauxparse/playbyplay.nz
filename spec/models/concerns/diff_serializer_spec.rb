# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiffSerializer do
  subject(:serializer) { DiffSerializer.new }
  let(:first) { 'pisces' }
  let(:second) { 'iscariot' }
  let(:diff) { { text: Diff::LCS.diff(first, second) } }

  let(:dumped) do
    '{"text":[[["-",0,"p"]],[["-",4,"e"],["-",5,"s"],["+",3,"a"],["+",4,"r"],' \
      '["+",5,"i"],["+",6,"o"],["+",7,"t"]]]}'
  end

  describe '#dump' do
    subject { serializer.dump(diff) }
    it { is_expected.to eq dumped }
  end

  describe '#load' do
    subject { serializer.load(dumped) }
    it { is_expected.to eq(diff) }
  end
end
