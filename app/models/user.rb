class User < ApplicationRecord
    before_save { self.email = email.downcase}
     #user has many follows
    has_many :follows, foreign_key: :follower_id
    #association uses the through option to specify that the User model can access the followings association by going through the Follow model
    has_many :followings, through: :follows, source: :followed     
    
    has_many :reverse_follows, foreign_key: :followed_id, class_name: 'Follow'
    #User can access their followers by looking at the users who are following them through the reverse_follows association
    has_many :followers, through: :reverse_follows, source: :follower
    
    has_many :articles, dependent: :destroy #specifies that when a User object is destroyed, all associated Article objects should also be destroyed
    validates :username, presence: true, 
                        uniqueness: { case_sensitive: false}, 
                        length: {minimum: 3, maximum: 25}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,presence: true, 
                        length: {maximum: 105}, 
                        uniqueness: { case_sensitive: false},
                        format: {with: VALID_EMAIL_REGEX}

    has_secure_password           
end