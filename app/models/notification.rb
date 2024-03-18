class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :friend, optional: true
end
