class Badge < ApplicationRecord

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  has_one_attached :image

  validates :title, presence: true
  validates :title, uniqueness: { scope: :rule, message: "This combination of title and rule already exists." }
  validates :image, attached: true, content_type: [:png, :jpg, :jpeg]

end
