class User < ApplicationRecord
    before_save { self.email = email.downcase}
    has_many :follows, foreign_key: :follower_id
    has_many :followings, through: :follows, source: :followed
    has_many :reverse_follows, foreign_key: :followed_id, class_name: 'Follow'
    has_many :followers, through: :reverse_follows, source: :follower
    
    has_many :articles, dependent: :destroy
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