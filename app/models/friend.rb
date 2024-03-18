class Friend < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'
  has_many :notifications, dependent: :destroy

  validates :follower, uniqueness: { scope: :following }
end
