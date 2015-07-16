class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy

  after_create :activity_review
  after_save :set_avarage_rating
  after_destroy :set_avarage_rating

  private
  def set_avarage_rating
    rate = self.book.reviews.average :rating
    book.rate = rate if rate
    book.save
  end

  def activity_review
    Activity.create! action: "review|#{self.id}|", user_id: self.user.id
  end
end
