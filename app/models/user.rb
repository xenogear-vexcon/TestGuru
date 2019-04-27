class User < ApplicationRecord

  def tests_by_level(test_level)
    Test.join('JOIN results ON results.test_id = tests.id')
        .where(level: test_level, results: { user_id: id })
  end

end