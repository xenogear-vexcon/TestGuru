class Badge < ApplicationRecord

  BADGE_RULES = %w[first_attempt tests_by_category_finished tests_by_level_finished].freeze

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  mount_uploader :file, FileUploader

  validates :title, :rule, presence: true
  validates :title, uniqueness: true

end
