class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :update]

  def index
    @children = Child.all.order(order_str(params[:sort]))
  end

  def show
    # 新入園以外（途中退園・一時入園・一時入園終了・休園中）はステータスを表記する。
  end

  def new
    @child = Child.new
    set_history_code_list('new')
  end

  def edit
    set_history_code_list('edit')
  end

  def create
    @child = Child.new(child_params)

    respond_to do |format|
      if @child.save
        # incでchild_history作る
        ChildHistory.create(@child, 'inc', decrypt_change_date(params[:child_history]))

        format.html { redirect_to @child, notice: 'Child was successfully created.' }
        format.json { render :show, status: :created, location: @child }
      else
        format.html { render :new }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      # updateの前にchild_history作るかどうかチェック
      create_child_history_flg = ( @child.history_code != params[:child][:history_code] )

      if @child.update(child_params)
        # child_history作る（作らないかもしれない）
        create_child_history(@child) if create_child_history_flg

        format.html { redirect_to @child, notice: 'Child was successfully updated.' }
        format.json { render :show, status: :ok, location: @child }
      else
        format.html { render :edit }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_child
      @child = Child.find(params[:id])
    end

    def child_params
      params.require(:child).permit(:unique_num, :class_room_id, :post_number, :address, :l_phone_number, :c_phone_number, :full_name, :full_name_f, :sex_code, :history_code)
    end

    def order_str(sort_params)
      case sort_params
        when 'name'         then 'full_name_f'
        when 'name desc'    then 'full_name_f desc'
        when 'class'        then 'class_room_id, full_name_f'
        when 'class desc'   then 'class_room_id desc, full_name_f'
        when 'status'       then 'history_code, full_name_f'
        when 'status desc'  then 'history_code desc, full_name_f'
        when 'address'      then 'address, full_name_f'
        when 'address desc' then 'address desc, full_name_f'
        else                   'full_name_f'
      end# << ', sex_code desc'
    end

    def set_history_code_list(action_name)
      Constants::ALL_CODES['history'].each do |key, value|
        if value[:check_string].try(:include?, action_name)
          (@history_code_list ||= []) << [key, value[:view_name]]
        end
      end
    end

    def create_child_history(child)
      target_check_string = Constants::ALL_CODES['history'][child.history_code][:check_string]
      if target_check_string.include?('inc')
        change_type = 'inc'
      elsif target_check_string.include?('dec')
        change_type = 'dec'
      else
        # 休園などは人数に変動なしなので作らない
        return
      end
      ChildHistory.create(child, change_type, decrypt_change_date(params[:child_history]))
    end

    def decrypt_change_date(ch_params)
      (ch_params['change_date(1i)'] + sprintf("%02d", ch_params['change_date(2i)']) + sprintf("%02d", ch_params['change_date(3i)'])).to_date
    end
end
