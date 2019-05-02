class User < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :tests_users
  has_many :tests, through: :tests_users
  has_many :results, dependent: :destroy
  has_many :authorship, class_name: "Test", foreign_key: "author_id", dependent: :nullify
  
  def tests_by_level(test_level)
    Test.join('JOIN results ON results.test_id = tests.id')
        .where(level: test_level, results: { user_id: id })
  end

end