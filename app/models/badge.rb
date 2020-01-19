class Badge < ApplicationRecord

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  has_one_attached :image

  validates :title, uniqueness: true, inclusion: { in: BadgeService.badge_titles.map{|title| "#{title}"}, message: "%{value} is not a valid title" }
  validates :rule, inclusion: { in: BadgeService.badge_rules.map{|rule| "#{rule}"}, message: "%{value} is not a valid rule" }
  validates :option, uniqueness: { scope: :rule, message: "This combination of option and rule already exists." },
                     inclusion: { in: BadgeService.option.map{|option| "#{option}"}, message: "%{value} is not a valid option" }
  validates :image, attached: true, content_type: [:png, :jpg, :jpeg]

end
