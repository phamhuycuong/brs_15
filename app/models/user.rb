class User < ActiveRecord::Base
  enum role: Settings.roles
  after_initialize :set_default_role, if: :new_record?

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :readings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower,
                       dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :reading_books, through: :readings, source: :book
  has_many :liked_activites, through: :likes, source: :activity

  def set_default_role
    self.role ||= :normal
  end

  def add_favorite book
    Favorite.create user_id: self.id, book_id: book.id
  end

  def added_favorite? book
    self.favorited_books.include? book
  end

  def added_reading? book
    self.reading_books.include? book
  end

  def find_status book
    added_reading?(book) ? self.readings.find_by(book_id: book.id).status
      : Settings.reading_status[0]
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def liked_activity activity
    self.liked_activites.include? activity
  end
end
