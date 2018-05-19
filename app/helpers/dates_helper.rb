# frozen_string_literal: true

module DatesHelper
  def recent_day(date)
    case Time.zone.today - date
    when 0 then t('date.today')
    when 1 then t('date.yesterday')
    else l(date, format: '%A')
    end
  end
end
