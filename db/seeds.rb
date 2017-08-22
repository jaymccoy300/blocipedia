require 'random_data'

5.times do
  User.create!(
    email: RandomData.random_email,
    password: 'standardpassword',
    standard: true,
    premium: false,
    admin: false
  )
end

4.times do
  User.create!(
    email: RandomData.random_email,
    password: 'premiumpassword',
    standard: false,
    premium: true,
    admin: false
  )
end

3.times do
  User.create!(
    email: RandomData.random_email,
    password: 'adminpassword',
    standard: false,
    premium: false,
    admin: true
  )
end

users = User.all

10.times do
  Wiki.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    private: false
  )
end

wikis = Wiki.all

puts 'Seed finished'
puts "#{users.count} users created"
puts "#{wikis.count} wikis created"
