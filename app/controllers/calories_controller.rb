class CaloriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[show edit update destroy]

  def index
    @calories = current_user.calorie.order('created_at DESC')
    # min - max dates for queries
    if logs_limits
      @first_log = logs_limits[:first_log]
      @last_log = logs_limits[:last_log]
    end
    # comment query
    if params[:query] && !params[:query].empty?
      @calories = @calories.comment_search(params[:query])
      @filtered_comment = true
    end
    # date query
    if params[:min_date] && !params[:min_date].empty?
      @calories = @calories.min_date_filter(params[:min_date])
      @filtered_min = true
    end
    if params[:max_date] && !params[:max_date].empty?
      @calories = @calories.max_date_filter(params[:max_date])
      @filtered_max = true
    end
    # pagination
    @chart = @calories.group(:register_type).group('date(created_at)').order('date(created_at) DESC').limit(120).sum(:ammount)
    @calories = Kaminari.paginate_array(@calories).page(params[:page]).per(10)
  end

  def chart
    date = Date.today - 30.days

    @calories = current_user.calorie.where('created_at >= ?',
                                           date).group(:register_type).group_by_day(:created_at).sum(:ammount)

    # date = Date.today - 30.days
    # @calories = current_user.calorie.where('created_at >= ?', date)
    #                         .group('date(created_at)').group(:register_type)
    #                         .order('date(created_at) DESC').sum(:ammount)
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

    # date filter
    # if params[:days_back] && !params[:days_back].empty?
    #   @calories = @calories.days_back(params[:days_back])
    # else
    #   days_ago = Date.today - 30
    #   @calories = if params[:aggrupation] && !params[:aggrupation].empty?
    #                 @calories.default_days(params[:aggrupation])
    #               else
    #                 @calories.where('created_at >= ?', days_ago)
    #               end
    # end
    # # group_by selection
    # @calories = if params[:aggrupation] && !params[:aggrupation].empty?
    #               @calories.group_chart(params[:aggrupation])
    #             else
    #               @calories.group_by_day(:created_at)
    #             end
    # @calories = @calories.order('created_at DESC').sum(:ammount)
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

  def logs_limits
    limits = {}
    if current_user.calorie.first
      limits = {
        first_log: current_user.calorie.first.created_at.strftime('%Y-%m-%d'),
        last_log: current_user.calorie.last.created_at.strftime('%Y-%m-%d')
      }
    end
    limits
  end
end
