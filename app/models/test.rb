class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User"
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :users, through: :results

  validates :title, presence: true, uniqueness: { scope: :level,
    message: "can be only one test with that title and level" }
  validates :level, numericality: { greater_than_or_equal_to: 0,
                                    only_integer: true }

  default_scope { order(title: :desc) }
  scope :easy, -> { where(level: (0..1)) }
  scope :medium, -> { where(level: (2..4)) }
  scope :hard, -> { where(level: (5..Float::INFINITY)) }
  scope :sort_by_category, -> (test_category) { joins(:category)
                                                .where(categories: { title: test_category }) }

  def self.by_category(cat)
    sort_by_category(cat).pluck(:title)
  end

end
