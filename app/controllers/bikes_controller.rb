class BikesController < ApplicationController
  
  before_action :get_bike, only: [:show,:edit,:update, :destroy]
 
  
  def index
    @bikes = Bike.all
  end

  def new
    if !user_signed_in?
    
      redirect_to '/users/sign_in'
    else
    	@bike = Bike.new
      @bike = current_user.bikes.build
    end
  end
  def create
    @bike = current_user.bikes.build(bike_params)
    if @bike.save
      redirect_to @bike, notice: 'The bike was successfully updated.'
    else 
      render 'new'
    end
  end

  def show

  end

  def edit
    @frames = Frame.all
    @wheels = Wheel.all
  end

 def update
    respond_to do |format|
      if @bike.update(bike_params)
        Bike.weight_total(@bike)
        format.html { redirect_to @bike, notice: 'The bike was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @bike.destroy
      redirect_to bikes_path
    end
  end

  private 

    def get_bike
      @bike = Bike.find(params[:id])
      if current_user != @bike.user
        redirect_to root_path
      end
    end

    def bike_params
      params.require(:bike).permit(:name, :description, :user_id, :frame_id, :wheel_id)
    end



end
