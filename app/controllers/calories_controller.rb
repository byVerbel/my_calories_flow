class CaloriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @calories = Calorie.all
  end

  def show
    @calorie = Calorie.find(params[:id])
  end

  def new
    @calorie = current_user.calorie.build
  end

  def create
    @calorie = current_user.calorie.build(calorie_params)
    if @calorie.save
      flash[:success] = 'Calorie register succesfully saved!'
      redirect_to @calorie
    else
      flash[:error] = 'Calorie register was not saved!'
      render :new
    end
  end

  def edit
    @calorie = Calorie.find(params[:id])
  end

  def update
    @calorie = Calorie.update(calorie_params)
    if @calorie.save
      flash[:success] = 'Calorie register succesfully updated!'
      redirect_to @calorie
    else
      flash[:error] = 'Calorie register was not updated!'
      render :edit
    end
  end

  def destroy
    Calorie.find(params[:id]).destroy
    flash[:success] = 'Calorie register deleted'
    redirect_to calories_path
  end

  def correct_user
    @calorie = current_user.calorie.find_by(id: params[:id])
    redirect_to calory_path, notice: 'Not authorized to edit this calorie.' if @calorie.nil?
  end

  private

  def calorie_params
    params.require(:calorie).permit(:ammount, :register_type, :register_comment)
  end
end
