class User < ApplicationRecord
  before_create :generate_token

	has_many :posts
  has_many :followers, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :followers_users, through: :followers, source: :following, class_name: "User"
  has_many :followings, class_name: 'Follow', foreign_key: 'following_id'
  has_many :followings_users, through: :followings, source: :follower, class_name: "User" 
  has_many :followings_posts, ->{ distinct }, through: :followings_users, source: :posts, class_name: "Post"

  mount_uploader :avatar, AvatarUploader

	validates_presence_of :email, :name, :password
	validates_uniqueness_of :email
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 


  def update_token
    self.generate_token
  end

  def follow?(user)
    self.followings_users.include?(user)
  end

  def num_of_followers
    self.followers.size
  end

  def num_of_followings
    self.followings.size
  end

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token: random_token)
    end
  end

end
