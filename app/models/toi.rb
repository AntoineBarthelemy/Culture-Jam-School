class Toi < ApplicationRecord
  belongs_to :category
  has_many :posts, dependent: :destroy
  has_many :bookmarks, foreign_key: "toi_id"
  has_many :users, through: :bookmarks
  has_many :toi_artists, dependent: :destroy
  has_many :artists, through: :toi_artists
  has_one_attached :photo

  validates :title, :category, :description, presence: true
  validates :trailer, presence: true, if: :cinema?
  validates :location, presence: true, if: :spectacle?
  validates :location, presence: true, if: :exposition?

  def cinema?
    self.category == "Cinema"
  end

  def spectacle?
    self.category == "Spectacle"
  end

  def exposition?
    self.category == "Exposition"
  end

  def followed_users_posts(user)
    posts.where(user_id: user.followed_users.pluck(:id))
  end

  def starify_average(user)
    avg_rating = 0
    posts.each do |post|
      avg_rating += post.rating

    end
    avg_rating /= posts.count
    stars = ''
    full_stars = avg_rating / 2

    half_star = avg_rating % 2
    full_stars.to_i.times do
      stars += "<i class='fa-solid fa-star'></i>"

    end
    half_star.to_i.times do
      stars += "<i class='fa-solid fa-star-half-stroke'></i>"
    end
    (((10-avg_rating)-(10-avg_rating)%2)/2).times do
      stars += "<i class='fa-regular fa-star'></i>"
    end
    stars

  end
end
