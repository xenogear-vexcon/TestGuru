class User < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :tests, through: :results
  has_many :authorship, class_name: "Test", foreign_key: "author_id"
  
  def tests_by_level(test_level)
    tests.where(level: test_level)
  end

end