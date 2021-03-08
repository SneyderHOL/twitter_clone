class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # VALID_USERNAME_REGEX = /\A[\w]+\z/
  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  # VALID_FULLNAME_REGEX = /\A[a-zA-Z ]+\z/
  validates :fullname, presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 140 }
end
