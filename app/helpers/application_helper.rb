module ApplicationHelper
  def fix_url(str)
    str.start_with?(/https?:\/\//) ? str : "http://#{str}"
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end

    dt.strftime("%d/%m/%Y %R %Z")
  end

  def ajax_flash(div_id)
    response = ''
    flash_div = ''

    flash.each do |name, msg|
      if msg.is_a?(String)
        flash_div = "<div class=\"alert alert-#{name == 'notice' ? 'success' : 'danger'} ajax_flash\"> <a class=\"close\" data-dismiss=\"alert\">&#215;</a> <div id=\"flash_#{name == 'notice' ? 'notice' : 'error'}\">#{h(msg)}</div> </div>" 
      end
    end

    response = "$('.alert').remove();$('#{div_id}').prepend('#{flash_div}');"
    response.html_safe
  end
end
