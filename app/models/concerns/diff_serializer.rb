# frozen_string_literal: true

class DiffSerializer
  def self.dump(diff)
    (diff&.transform_values { |patch| patch.flatten.map(&:to_a) } || {}).to_json
  end

  def self.load(diff)
    JSON.parse(diff || '{}').transform_values do |patch|
      patch.map { |change| Diff::LCS::Change.from_a(change) }
    end
  end
end
