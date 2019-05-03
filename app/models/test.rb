class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :users, through: :results

  def self.sort_by_category(test_category)
    joins(:category).where(categories: { title: test_category })
                    .order(title: :desc).pluck(:title)
  end
end
