# Create an Admin User
AdminUser.create(
  email: 'admin@runarh.com', 
  password: 'secret', 
  password_confirmation: 'secret', 
  name: 'Carlos', 
  last_name: 'Gomez'
)

# Create an employee user with random name and last_name
n = 0
names = ['Peter', 'Jonh', 'Maria', 'Edward', 'Charles', 'Claudia', 'Michael', 'Nicole', 'Natalie', 'Sofia']
last_names = ['Anderson', 'Berry', 'Edmunds', 'Churchill', 'Ferguson', 'Jackson', 'Lawrence', 'Morrison', 'Paige', 'Quinn']
gender = ['Male', 'Female']

10.times do
  User.create(
    email: "employee_#{n += 1}@runarh.com", 
    password: 'password', 
    password_confirmation: 'password', 
    name: names[SecureRandom.random_number(0..9)], 
    last_name: last_names[SecureRandom.random_number(0..9)],
    gender: gender[SecureRandom.random_number(0..1)]
  )
end

users = User.all.each do |u|
  10.times do
    WorkingDay.create!(
      checkin: 2.hours.from_now,
      checkout: 2.hours.from_now + 6.hours,
      user_id: u.id
    )
  end
end