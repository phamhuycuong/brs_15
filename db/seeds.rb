# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
20.times do |n|
  User.create!(name: "user_user" + n.to_s,
    email: "user" + n.to_s + "@gmail.com",
    password: "password"
  )
end

10.times do |n|
  Category.create!(name: "Category" + n.to_s, content: "Content")
end

100.times do |n|
  Book.create!(title: "BookBook" + n.to_s,
    publish_date: "2015/07/08",
    author: "Author" + n.to_s,
    number_page: n + 100,
    content: "Content content",
    category_id: 1
  )
end

User.all.each do |user|
  @books = Book.order("random()").limit(10)
  @books.all.each do |book|
    user.add_favorite(book)
    Activity.create!(user_id: user.id, action: "favorite|" + book.id.to_s)
  end
end

# 100.times do |n|
#   5.times do |m|
#     Review.create!(subject: "This is subject of rating !!",
#       content: "Content of rating",
#       rating: rand(1..5),
#       user_id: 1,
#       book_id: n)
#   end
# end
