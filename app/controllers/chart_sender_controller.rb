class ChartSenderController < ApplicationController
  def chart
    @user = User.find_by(email: params[:email])
    @token = params[:token]
    if @user&.valid_token?(@token)
      flash[:success] = 'Chart opened succesfuly'

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
    else
      flash[:danger] = 'Invalid share link'
      redirect_to root_url
    end
  end
end
