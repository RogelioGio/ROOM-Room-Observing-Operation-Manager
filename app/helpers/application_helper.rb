module ApplicationHelper
  def smart_date(time)
    return if time.nil?

    if time > 1.day.ago
      "#{time_ago_in_words(time)} ago"
    else
      time.strftime("%Y-%m-%d %H:%M")
    end
  end
end
