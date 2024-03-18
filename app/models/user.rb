class User < ApplicationRecord
  has_many :friends, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, -> { distinct }, through: :friends, source: :following, dependent: :destroy
  # has_many :followers, class_name: "Friend", foreign_key: "follower_id"
  # has_many :followed_users, though: :followers, source: :following
  has_many :followings, class_name: "Friend", foreign_key: "following_id", dependent: :destroy
  has_many :following_users, -> { distinct }, through: :followings, source: :follower, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :saved_tois, through: :bookmarks, source: :toi
  has_one_attached :photo
  has_many :notifications, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:username]

  has_many :posts, dependent: :destroy
  validates :email, :username, uniqueness: true
  validates :email, :username, presence: true
  after_create -> { selfriend }
  after_create :add_default_photo

  def followed_users_tois
    Toi.joins(:posts).where(posts: { user_id: followed_users.pluck(:id).push(self.id) }).distinct
  end

  def follow?(other_user)
    friends.where(following_id: other_user.id).exists?
  end


  def add_default_photo
    unless photo.attached?
      # Assurez-vous que le chemin d'accès et le nom du fichier correspondent à votre fichier d'photo par défaut
      photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'avatar.jpeg')), filename: 'avatar.jpeg', content_type: 'image/jpeg')
    end
  end

  def selfriend
    Friend.create(follower: self, following: self)
  end

  def unread_notifications
    self.notifications.where(read: false)
  end
end
