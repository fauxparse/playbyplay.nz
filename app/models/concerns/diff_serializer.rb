# frozen_string_literal: true

class DiffSerializer
  def self.dump(diff)
    new.dump(diff)
  end

  def self.load(diff)
    new.load(diff)
  end

  def dump(diff)
    (diff || {}).transform_values { |hunks| compressor.compress(hunks) }.to_json
  end

  def load(diff)
    JSON
      .parse(diff || '{}')
      .symbolize_keys
      .transform_values do |hunks|
        compressor.uncompress(hunks).map do |hunk|
          hunk.map { |change| Diff::LCS::Change.from_a(change) }
        end
      end
  end

  private

  def compressor
    @compressor ||= DiffCompressor.new
  end
end
