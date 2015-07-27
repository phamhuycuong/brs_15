FactoryGirl.define do
  sequence(:title) {|n| "Book Serial #{n}"}
  sequence(:author) {|n| "Author #{n}"}
  factory :book do
    title
    author
    publish_date "2015-05-05"
    number_page 10
    to_create {|instance| instance.save(validate: false) }
  end
end
