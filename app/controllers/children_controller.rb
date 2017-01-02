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
    set_history_code_list(['inc', 'temp_inc'])
  end

  def edit
    set_history_code_list(change_to_history_code_list(@child.status_code))
  end

  def create
    @child = Child.new(child_params)

    # ステータスの設定（createの場合は入園か一時入園）
    # 入力忘れの場合の対応として「入園」にしちゃう
    @child.status_code = change_to_status_code(params[:child_history][:history_code] ||= 'inc')
    change_date = decrypt_change_date(params[:child_history])
    @child.status_change_date = change_date

    respond_to do |format|
      if @child.save
        # incでchild_history作る
        ChildHistory.create(@child, params[:child_history][:history_code], change_date, 'inc')

        format.html { redirect_to @child, notice: 'Child was successfully created.' }
        format.json { render :show, status: :created, location: @child }
      else
        set_history_code_list(['inc', 'temp_inc'])
        format.html { render :new }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      # updateの前にchild_history作るかどうか（と、ステータス変更するかどうか）のチェック
      if change_flg = params[:child_history][:history_code] != 'keep'
        params[:child][:status_code] = change_to_status_code(params[:child_history][:history_code])
        change_date = decrypt_change_date(params[:child_history])
        params[:child][:status_change_date] = change_date
      end

      if @child.update(child_params)
        # child_history作る（作らないかもしれない）
        if change_flg
          create_child_history(params[:child_history][:history_code], change_date)
        end

        format.html { redirect_to @child, notice: 'Child was successfully updated.' }
        format.json { render :show, status: :ok, location: @child }
      else
        set_history_code_list(change_to_history_code_list(@child.status_code))
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
      params.require(:child).permit(:unique_num, :class_room_id, :post_number, :address, :l_phone_number, :c_phone_number, :full_name, :full_name_f, :sex_code, :status_code, :status_change_date)
    end

    def order_str(sort_params)
      case sort_params
        when 'name'         then 'full_name_f'
        when 'name desc'    then 'full_name_f desc'
        when 'class'        then 'class_room_id, full_name_f'
        when 'class desc'   then 'class_room_id desc, full_name_f'
        when 'status'       then 'status_code, full_name_f'
        when 'status desc'  then 'status_code desc, full_name_f'
        when 'address'      then 'address, full_name_f'
        when 'address desc' then 'address desc, full_name_f'
        else                   'full_name_f'
      end# << ', sex_code desc'
    end

    def set_history_code_list(history_code_list)
      history_code_list.each do |history_code|
        (@history_code_list ||= []) << [history_code, Constants::ALL_CODES['history'][history_code][:view_name]]
      end
    end

    def change_to_history_code_list(status_code)
      case status_code
      when 'enrollment' then ['dec', 'suspend']
      when 'exit'       then ['inc', 'temp_inc']
      when 'suspend'    then ['dec', 'suspend_end']
      when 'temp'       then ['temp_dec']
      end
    end

    def change_to_status_code(history_code)
      case history_code
      when 'inc'         then 'enrollment'
      when 'temp_inc'    then 'temp'
      when 'dec'         then 'exit' 
      when 'temp_dec'    then 'exit'
      when 'suspend'     then 'suspend'
      when 'suspend_end' then 'enrollment'
      when 'never'       then 'graduation'
      end
    end

    def create_child_history(history_code, change_date)
      target_check_string = Constants::ALL_CODES['history'][history_code][:check_string]
      if target_check_string.include?('inc')
        change_type = 'inc'
      elsif target_check_string.include?('dec')
        change_type = 'dec'
      else
        # 休園などは人数に変動なしなので作らない
        return
      end
      ChildHistory.create(@child, history_code, change_date, change_type)
    end

    def decrypt_change_date(ch_params)
      (ch_params['change_date(1i)'] + sprintf("%02d", ch_params['change_date(2i)']) + sprintf("%02d", ch_params['change_date(3i)'])).to_date
    end
end
