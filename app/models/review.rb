class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy
end
