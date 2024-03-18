class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :toi, class_name: "Toi"
end
