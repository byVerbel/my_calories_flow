# Create a main sample user.
User.create!(firstname: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar')

user = User.first
days_ago = 1000
days_ago.times do
  current_date = Date.today - days_ago
  4.times do
    cal = Faker::Number.between(from: 1, to: 200)
    reg_type = %w[Gained Burned].sample
    comment = if reg_type == 'Gained'
                'Comí de más'
              else
                'Hice ejercicio'
              end
    user.calorie.create!(ammount: cal, register_type: reg_type, register_comment: comment, created_at: current_date,
                         updated_at: current_date)
  end
  days_ago -= 1
end

### SEED FOR A LOT OF USERS
# Generate a bunch of additional users.
# users_number = 49
# users_number.times do |n|
#   firstname = Faker::Name.first_name
#   lastname = Faker::Name.last_name
#   email = "#{firstname}-#{n + 1}@railstutorial.org"
#   password = 'password'
#   User.create!(firstname: firstname,
#                lastname: lastname,
#                email: email,
#                password: password,
#                password_confirmation: password)
# end

# Generate calories for a subset of users.
# users = User.order('created_at DESC').take(users_number)

# days_ago = 120
# days_ago.times do
#   current_date = Date.today - days_ago
#   users.each do |user|
#     4.times do
#       cal = Faker::Number.between(from: 1, to: 200)
#       reg_type = %w[Gained Burned].sample
#       comment = if reg_type == 'Gained'
#                   'Comí de más'
#                 else
#                   'Hice ejercicio'
#                 end
#       user.calorie.create!(ammount: cal, register_type: reg_type, register_comment: comment, created_at: current_date,
#                            updated_at: current_date)
#     end
#   end
#   days_ago -= 1
# end
