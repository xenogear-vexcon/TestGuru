class Badge < ApplicationRecord

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  has_one_attached :image

  validates :title, presence: true, uniqueness: true
  validates :rule, inclusion: { in: %w(tests_by_category_finished first_attempt tests_by_level_finished),
    message: "%{value} is not a valid rule" }
  validates :option, uniqueness: { scope: :rule, message: "This combination of option and rule already exists." }
  validates :image, attached: true, content_type: [:png, :jpg, :jpeg]

end
