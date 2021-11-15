class CaloriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[show edit update destroy]

  def index
    @calories = current_user.calorie.order('created_at DESC')
    @calories = Kaminari.paginate_array(@calories).page(params[:page]).per(20)
  end

  def chart
    @calories = current_user.calorie.group(:register_type).group_by_day(:created_at).order('created_at DESC').limit(30).sum(:ammount)
    # @gained = {}
    # @burned = {}
    # @calories.each do |calorie|
    #   if calorie[0][1] == 'Gained'
    #     @gained[calorie[0][0]] = calorie[1]
    #     @burned[calorie[0][0]] = 0
    #   else
    #     @gained[calorie[0][0]] = 0
    #     @burned[calorie[0][0]] = calorie[1]
    #   end
    # end
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
    @calorie = Calorie.find(params[:id])
    if @calorie.update(calorie_params)
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
    redirect_to calories_path, notice: 'Not authorized to see this log.' if @calorie.nil?
  end

  private

  def calorie_params
    params.require(:calorie).permit(:ammount, :register_type, :register_comment, :updated_at, :created_at)
  end
end
