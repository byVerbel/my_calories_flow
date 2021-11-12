# Create a main sample user.
User.create!(firstname: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar')

# Generate a bunch of additional users.
49.times do |n|
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  email = "#{firstname}-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(firstname: firstname,
               lastname: lastname,
               email: email,
               password: password,
               password_confirmation: password)
end

# Generate calories for a subset of users.
users = User.order(:created_at).take(50)
days_ago = 60
60.times do
  current_date = Date.today - days_ago
  users.each do |user|
    comment = Faker::Lorem.sentence(word_count: 5)
    cal = Faker::Number.between(from: 1, to: 300)
    reg_type = %w[Gained Burned].sample
    user.calorie.create!(ammount: cal, register_type: reg_type, register_comment: comment, created_at: current_date)
  end
  days_ago -= 1
end
