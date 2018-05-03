# frozen_string_literal: true

class DiffCompressor
  def compress(diff)
    diff.map do |hunk|
      hunk.inject([]) do |changes, change|
        collapse(changes, change.to_a)
      end
    end
  end

  def uncompress(diff)
    diff.map do |changes|
      expand(changes)
    end
  end

  private

  def collapse(changes, change)
    if can_combine?(changes.last, change)
      changes[0...-1] + [combine(changes.last, change)]
    else
      changes + [change]
    end
  end

  def can_combine?(one, other)
    one.present? &&
      other.last.present? &&
      one.first == other.first &&
      one.second + one.last.length == other.second
  end

  def combine(one, other)
    [one.first, one.second, one.last + other.last]
  end

  def expand(changes)
    changes.flat_map do |(op, pos, text)|
      text.chars.map.with_index { |char, i| [op, pos + i, char] }
    end
  end
end
