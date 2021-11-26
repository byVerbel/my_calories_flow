# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/chart_graph
  def chart_graph
    user = User.first
    user.chart_token = User.new_token
    UserMailer.chart_graph(user, 'byverbel@gmail.com')
  end
end
