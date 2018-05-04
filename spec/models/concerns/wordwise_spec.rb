# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wordwise do
  subject(:wordwise) { Wordwise.new }
  let(:old) { 'Here’s an old string.' }
  let(:new) { 'This is an edited string. Note the changes.' }

  describe '#split' do
    subject { wordwise.split(old) }
    let(:expected_split) do
      ['Here', '’', 's', ' ', 'an', ' ', 'old', ' ', 'string', '.']
    end
    it { is_expected.to eq expected_split }
  end

  describe '#diff' do
    subject(:diff) { wordwise.diff(old, new) }

    it 'has the correct number of changes' do
      expect(diff.flatten).to have_exactly(15).items
    end
  end

  describe '#patch' do
    subject(:patched) { wordwise.patch(old, wordwise.diff(old, new)) }
    it { is_expected.to eq new }
  end

  describe '#unpatch' do
    subject(:patched) { wordwise.unpatch(new, wordwise.diff(old, new)) }
    it { is_expected.to eq old }
  end
end
