module ApplicationHelper
  def fix_url(str)
    str.start_with?(/https?:\/\//) ? str : "http://#{str}"
  end

  def display_datetime(dt)
    dt.to_s(:long)
  end
end
