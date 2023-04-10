class Blogger < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #user has many follows
  has_many :follows, foreign_key: :follower_id
  #association uses the through option to specify that the User model can access the followings association by going through the Follow model
  #current model has many "followings", which are retrieved by following the "follows" association and finding the records that are being followed by the current model's record.
  has_many :followings, through: :follows, source: :followed     
  #has_many association to followers through reverse_follows, which retrieves all the users who are following a particular user
  has_many :reverse_follows, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  #User can access their followers by looking at the users who are following them through the reverse_follows association
  has_many :followers, through: :reverse_follows, source: :follower
  
  has_many :articles, dependent: :destroy #specifies that when a User object is destroyed, all associated Article objects should also be destroyed
  
end
