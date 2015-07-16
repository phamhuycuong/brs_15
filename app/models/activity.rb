class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy

  def translate
    if %w[favorite comment read follow unfollow review].include? self.action.split("|")[0]
      self.user.name + " " + self.send("translate_" + self.action.split("|")[0])
    else
      self.user.name + " " + self.action
    end
  end

  def translate_favorite
    book = Book.find(self.action.split("|")[1].to_i) rescue nil
    book ? I18n.t("activities.translate.favorite") + book.title
      : I18n.t("activities.translate.favorite_nil")  + self.action.split("|")[1]
  end

  def translate_comment
    comment = Comment.find(self.action.split("|")[1].to_i) rescue nil
    comment ? I18n.t("activities.translate.comment") + comment.review.book.title
      : I18n.t("activities.translate.comment_nil")  + self.action.split("|")[1]
  end

  def translate_read
    book = Book.find(self.action.split("|")[1].to_i) rescue nil
    book ? I18n.t("activities.translate.read") + book.title
      : I18n.t("activities.translate.read_nil")  + self.action.split("|")[1]
  end

  def translate_follow
    follow = User.find(self.action.split("|")[1].to_i) rescue nil
    follow ? I18n.t("activities.translate.follow") + follow.name
      : I18n.t("activities.translate.follow_nil")  + self.action.split("|")[1]
  end

  def translate_unfollow
    unfollow = User.find(self.action.split("|")[1].to_i) rescue nil
    unfollow ? I18n.t("activities.translate.unfollow") + unfollow.name
      : I18n.t("activities.translate.unfollow_nil")  + self.action.split("|")[1]
  end

  def translate_review
    review = Review.find(self.action.split("|")[1].to_i) rescue nil
    review ? I18n.t("activities.translate.review") + review.book.title
      : I18n.t("activities.translate.review_nil")  + self.action.split("|")[1]
  end
end
