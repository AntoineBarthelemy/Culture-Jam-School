class Category < ApplicationRecord
  has_many :tois, dependent: :destroy

  validates :name, inclusion: { in: %w[Cinema Spectacle Litterature Exposition] }
end
