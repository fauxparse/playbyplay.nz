# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Productions do
  subject(:query) { Productions.new(parameters) }

  let(:plays) do
    <<~PLAYS.split("\n")
      All's Well That Ends Well
      Antony and Cleopatra
      As You Like It
      Comedy of Errors
      Coriolanus
      Cymbeline
      Hamlet
      Henry IV, Part I
      Henry IV, Part II
      Henry V
      Henry VI, Part I
      Henry VI, Part II
      Henry VI, Part III
      Henry VIII
      Julius Caesar
      King John
      King Lear
      Love's Labour's Lost
      Macbeth
      Measure for Measure
      Merchant of Venice
      Merry Wives of Windsor
      Midsummer Night's Dream
      Much Ado about Nothing
      Othello
      Pericles
      Richard II
      Richard III
      Romeo and Juliet
      Taming of the Shrew
      Tempest
      Timon of Athens
      Titus Andronicus
      Troilus and Cressida
      Twelfth Night
      Two Gentlemen of Verona
      Winter's Tale
    PLAYS
  end

  before do
    plays.each { |play| create(:production, name: play) }
  end

  context 'without parameters' do
    let(:parameters) { {} }

    it { is_expected.to have_exactly(37).items }
  end

  context 'with a string query' do
    let(:parameters) { { query: 'hen' } }

    it { is_expected.to have_exactly(8).items }
  end

  context 'with a limit' do
    let(:parameters) { { limit: 10 } }

    it { is_expected.to have_exactly(10).items }
  end
end
