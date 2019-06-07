class User < ApplicationRecord
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages, dependent: :destroy
  has_many :authorship, class_name: "Test", foreign_key: "author_id"

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  def tests_by_level(test_level)
    tests.where(level: test_level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test: test)
  end
end