class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets, dependent: :destroy
  # VALID_USERNAME_REGEX = /\A[\w]+\z/
  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  # VALID_FULLNAME_REGEX = /\A[a-zA-Z ]+\z/
  validates :fullname, presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 140 }
  has_many :followers_on_list, foreign_key: "followee_id", class_name: "Follow", dependent: :destroy
  has_many :followers, through: :followers_on_list
  
  has_many :followees_on_list, foreign_key: "follower_id", class_name: "Follow", dependent: :destroy
  has_many :followees, through: :followees_on_list
end
