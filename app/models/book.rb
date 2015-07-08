class Book < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :readings, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
