class ChartSenderController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user
      flash[:success] = 'Chart opened succesfuly'
      redirect_to chart_path(friend_user_id: @user.id)
    else
      flash[:danger] = 'Invalid share link'
      redirect_to root_url
    end
  end
end
