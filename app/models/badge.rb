class Badge < ApplicationRecord

  BADGE_RULES = %w[first_attempt tests_by_category_finished tests_by_level_finished]


  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  has_one_attached :image

  validates :title, :rule, presence: true
  validates :title, uniqueness: true
  validates :image, attached: true, content_type: [:png, :jpg, :jpeg]

end
