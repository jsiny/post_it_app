module ModelHelper
  def total_votes
    up_votes - down_votes
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-#{count}"
    end
  end
end