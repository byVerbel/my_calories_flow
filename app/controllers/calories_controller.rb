class CaloriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show chart]
  before_action :correct_user, only: %i[show edit update destroy]

  def index
    @calories = current_user.calorie
    # min - max dates for queries
    if (limits = logs_limits(current_user))
      @first_log = limits[:first_log]
      @last_log = limits[:last_log]
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
    @chart = @calories.group(:register_type).group_by_day(:created_at).limit(120).sum(:ammount)
    @calories = Kaminari.paginate_array(@calories.order('created_at DESC')).page(params[:page]).per(10)
  end

  def chart
    @user = current_user

    @calories = @user.calorie.group(:register_type)

    # date filter
    if params[:days_back] && !params[:days_back].empty?
      @calories = @calories.days_back(params[:days_back])
    else
      days_ago = Date.today - 30.days
      @calories = if params[:aggrupation] && !params[:aggrupation].empty?
                    @calories.default_days(params[:aggrupation])
                  else
                    @calories.where('created_at >= ?', days_ago)
                  end
    end
    # group_by selection
    @calories = if params[:aggrupation] && !params[:aggrupation].empty?
                  @calories.group_chart(params[:aggrupation])
                else
                  @calories.group_by_day(:created_at)
                end
    @calories = @calories.sum(:ammount)

    # Sharing the chart
    if params[:friend_email] && !params[:friend_email].empty? && valid_email?(params[:friend_email])
      friend = params[:friend_email]
      @user.share_chart(friend)
      flash.now[:info] = "Chart shared with #{friend}"
    end
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

  def logs_limits(user)
    limits = {}
    if user.calorie.first
      limits = {
        first_log: user.calorie.first.created_at.strftime('%Y-%m-%d'),
        last_log: user.calorie.last.created_at.strftime('%Y-%m-%d')
      }
    end
    limits
  end

  def valid_email?(email)
    if email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      true
    else
      false
    end
  end
end
