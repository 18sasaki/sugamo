module ApplicationHelper
  def class_room_link_td(class_room_id, option = {})
  	option.merge!(bgcolor: Constants::CR_HASH[class_room_id][:color])
  	class_room_link_block('td', class_room_id, option)
  end

  def class_room_link_span(class_room_id, option = {})
  	option.merge!(style: "background-color:#{Constants::CR_HASH[class_room_id][:color]};")
  	class_room_link_block('span', class_room_id, option)
  end

  def class_room_link_block(tag, class_room_id, option = {})
  	content_tag(tag, option) do
  		link_to "/class_rooms/#{class_room_id}", style: 'text-decoration: none;' do
  			Constants::CR_HASH[class_room_id][:name]
  		end
  	end
  end
end
