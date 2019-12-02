class BadgeService

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def call
    Badge.all.select { |badge| send("#{badge.rule}?", badge.option) }
  end

  private

  def first_attempt?(option)
    test_passage_uniq?
  end

  def tests_by_category_finished?(category)
    tests_by_category = Test.by_category(category).count
    user_tests_by_category = @user.tests.by_category(category).uniq.count

    test_passage_uniq? && (tests_by_category == user_tests_by_category)
    
  end

  def tests_by_level_finished?(level)
    tests_by_level = Test.where(level: level).count
    user_tests_by_level = @user.tests.where(level: level).count
    
    test_passage_uniq? && (tests_by_level == user_tests_by_level)
  end

  def test_passage_uniq?
    TestPassage.success.where(user_id: @user.id, test_id: @test.id).count == 1
  end

end
