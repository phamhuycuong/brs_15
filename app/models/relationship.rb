class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create :activity_follow
  before_destroy :activity_unfollow

  private
  def activity_follow
    Activity.create! action: "follow|#{self.followed_id}|", user_id: self.follower_id
  end

  def activity_unfollow
    Activity.create! action: "unfollow|#{self.followed_id}|", user_id: self.follower_id
  end
end
