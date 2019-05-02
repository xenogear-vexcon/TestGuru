class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User"
  has_many :questions, dependent: :destroy
  has_many :tests_users
  has_many :users, through: :tests_users

  def self.sort_by_category(test_category)
    Test.joins("JOIN categories ON categories.id = tests.category_id")
        .where(categories: { title: test_category })
        .order(title: :desc).pluck(:title)
  end
end
