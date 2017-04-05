module ApplicationHelper
  def class_room_link_td(class_room_id, option = {})
  	option.merge!(bgcolor: Constants::CR_HASH[class_room_id][:color])
  	class_room_link_block('td', class_room_id, option)
  end

  def class_room_link_span(class_room_id, option = {})
    option.merge!(style: "background-color:#{Constants::CR_HASH[class_room_id][:color]};")
    class_room_link_block('span', class_room_id, option)
  end

  def class_room_span(class_room_id, option = {})
    p ">>>>>>>>>>>>>>>>>>>>>#{Constants::CR_HASH}"
  	option.merge!(style: "background-color:#{Constants::CR_HASH[class_room_id][:color]};")
  	content_tag('span', Constants::CR_HASH[class_room_id][:name], option)
  end

  def class_room_link_block(tag, class_room_id, option = {})
  	content_tag(tag, option) do
  		link_to("/class_rooms/#{class_room_id}", style: 'text-decoration: none;') do
  			Constants::CR_HASH[class_room_id][:name]
  		end
  	end
  end

  def back_button_ww(str, button_option = {}, link_option = {})
    warning_str = "#{str}せずに戻ります。よろしいですか？"
    back_button(button_option.merge(data: {confirm: warning_str}), link_option)
  end

  def back_button(button_option = {}, link_option = {})
    link_button('戻る', :back, button_option.merge(class: 'btn btn-warning'), link_option)
  end

  def link_info_button(button_str, link_url, button_option = {}, link_option = {})
    link_button(button_str, link_url, button_option.merge(class: 'btn btn-info'), link_option = {})
  end

  def link_button(button_str, link_url, button_option = {}, link_option = {})
    link_to(link_url, link_option) do
      button_tag(button_str, button_option)
    end
  end

  def td_class(dairy)
    case dairy.dairy_code
    when 'full', 'half', 'free' then 'open'
    when 'holiday'
      if    dairy.date.wday == 0 then 'sunday'
      elsif dairy.date.wday == 6 then 'saturday'
      else                            'holiday'
      end
    when 'closed' then 'closed'
    end
  end
end
