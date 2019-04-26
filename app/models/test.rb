class Test < ApplicationRecord
  belongs_to :category

  def self.sort_by_category(test_category)
    Test.joins("JOIN categories ON categories.id = tests.category_id AND category = test_category")
                .order(title: :desc).pluck(:title)
  end
end
