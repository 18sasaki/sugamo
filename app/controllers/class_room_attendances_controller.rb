class ClassRoomAttendancesController < ApplicationController
  def confirm
  	@class_room = ClassRoom.find(params[:class_room_id])
  	@target_date = date_view(Dairy.find(params[:dairy_id]).date)
  	@page_title = "#{@today}"

    @cr_att_hash = ClassRoomAttendance.new(dairy_id: params[:dairy_id], class_room_id: params[:class_room_id]).attributes

    jb_ch = ChildHistory.get_jb_ch(params[:class_room_id], params[:dairy_id])
    @cr_att_hash['m_count'] = jb_ch.total_m_count
    @cr_att_hash['f_count'] = jb_ch.total_f_count
    @cr_att_hash['count']   = jb_ch.total_count
    @cr_att_hash['m_pre_count'] = jb_ch.total_m_count
    @cr_att_hash['f_pre_count'] = jb_ch.total_f_count
    @cr_att_hash['pre_count']   = jb_ch.total_count

  	@absent_children = AbsentChild.includes(:child).where(dairy_id: params[:dairy_id], class_room_id: params[:class_room_id])
  	@absent_children.each do |abc|
  		case abc.absent_code
  		when 'absent'
				@cr_att_hash['abs_count'] += 1
				@cr_att_hash['pre_count'] -= 1
  			if abc.child.sex_code == 'male'
  			@cr_att_hash['m_abs_count'] += 1
  				@cr_att_hash['m_pre_count'] -= 1
  			else
  				@cr_att_hash['f_abs_count'] += 1
  				@cr_att_hash['f_pre_count'] -= 1
  			end
  		when 'sus'
				@cr_att_hash['sus_count'] += 1
				@cr_att_hash['pre_count'] -= 1
  			if abc.child.sex_code == 'male'
  				@cr_att_hash['m_sus_count'] += 1
  				@cr_att_hash['m_pre_count'] -= 1
  			else
  				@cr_att_hash['f_sus_count'] += 1
  				@cr_att_hash['f_pre_count'] -= 1
  			end
  		when 'stop'
				@cr_att_hash['stop_count'] += 1
				@cr_att_hash['pre_count'] -= 1
  			if abc.child.sex_code == 'male'
  				@cr_att_hash['m_stop_count'] += 1
  				@cr_att_hash['m_pre_count'] -= 1
  			else
  				@cr_att_hash['f_stop_count'] += 1
  				@cr_att_hash['f_pre_count'] -= 1
  			end
  		when 'auth'
				@cr_att_hash['auth_count'] += 1
				@cr_att_hash['pre_count'] -= 1
  			if abc.child.sex_code == 'male'
  				@cr_att_hash['m_auth_count'] += 1
  				@cr_att_hash['m_pre_count'] -= 1
  			else
  				@cr_att_hash['f_auth_count'] += 1
  				@cr_att_hash['f_pre_count'] -= 1
  			end
  		end
  	end
  end

  def create
  	pp = params.permit(:dairy_id,
  		                 :class_room_id,
  	                   :m_count,
  	                   :f_count,
  	                   :count,
  	                   :m_pre_count,
  	                   :f_pre_count,
  	                   :pre_count,
  	                   :m_abs_count,
  	                   :f_abs_count,
  	                   :abs_count,
  	                   :m_sus_count,
  	                   :f_sus_count,
  	                   :sus_count,
  	                   :m_auth_count,
  	                   :f_auth_count,
  	                   :auth_count,
  	                   :m_stop_count,
  	                   :f_stop_count,
  	                   :stop_count)
  	ClassRoomAttendance.new(pp).save
  end
end






