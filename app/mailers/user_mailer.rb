class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.chart_graph.subject
  #
  def chart_graph(user, friend)
    @user = user
    @user.create_chart_token
    @friend = friend
    mail to: friend, subject: 'Look at my chart!'
  end
end
