# frozen_string_literal: true

class Wordwise
  def split(string)
    string.to_s.scan(/\w+|\W/)
  end

  def diff(old, new)
    Diff::LCS.diff(split(old), split(new))
  end

  def patch(old, patch)
    Diff::LCS.patch!(split(old), patch).join
  end

  def unpatch(new, patch)
    Diff::LCS.unpatch!(split(new), patch).join
  end
end
