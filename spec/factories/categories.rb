FactoryGirl.define do
  sequence(:name) {|n| "Category #{n}"}
  sequence(:content) {|n| "Category content #{n}"}
  factory :category do
    name
    content

    trait :with_short_name do
      after :build do |category|
        category.name = "n" * 4
      end
    end

    trait :with_short_content do
      after :build do |category|
        category.content = "c" * 4
      end
    end
  end
end
