class Tweet < ApplicationRecord
  belongs_to :user
  validates :message, presence: true, length: { maximum: 280 }
  validates :user, presence: true
  self.per_page = 10
end