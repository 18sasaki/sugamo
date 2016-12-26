class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :update]

  def index
    @children = Child.all.order(order_str(params[:sort]))
  end

  def show
  end

  def new
    @child = Child.new
  end

  def edit
  end

  def create
    @child = Child.new(child_params)

    respond_to do |format|
      if @child.save
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
      if @child.update(child_params)
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
      params.require(:child).permit(:unique_num, :class_room_id, :post_number, :address, :l_phone_number, :c_phone_number, :full_name, :full_name_f, :sex_code)
    end

    def order_str(sort_params)
      case sort_params
        when 'name'         then 'full_name_f'
        when 'name desc'    then 'full_name_f desc'
        when 'class'        then 'class_room_id, full_name_f'
        when 'class desc'   then 'class_room_id desc, full_name_f'
        when 'address'      then 'address, full_name_f'
        when 'address desc' then 'address desc, full_name_f'
        else                   'full_name_f'
      end# << ', sex_code desc'
    end
end
