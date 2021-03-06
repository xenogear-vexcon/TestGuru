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
    return unless @test_passage.success?

    TestPassage.where(user_id: @user.id, test_id: @test.id).success.count == 1
  end

  def tests_by_category_finished?(category)
    return unless @test_passage.success? && category == @test.category.title

    tests_by_rule = Test.where(category_id: Category.where(title: category).ids).ids
    user_tests_by_rule = @user.test_passages.success.where(test_id: tests_by_rule)

    if @user.user_badges.where(badge_id: Badge.where(option: category).ids).any?
      last_badge_date = @user.user_badges.where(badge_id: Badge.where(option: category).ids).order(created_at: :asc).last.created_at
      user_tests_by_rule = @user.test_passages.success.where(test_id: tests_by_rule).where("created_at > ?", last_badge_date)
    end

    tests_by_rule.count == user_tests_by_rule.pluck(:test_id).uniq.count
  end

  def tests_by_level_finished?(level)
    return unless @test_passage.success? && level.to_i == @test.level

    tests_by_rule = Test.where(level: level).ids
    user_tests_by_rule = @user.test_passages.success.where(test_id: tests_by_rule)

    if @user.user_badges.where(badge_id: Badge.where(option: level).ids).any?
      last_badge_date = @user.user_badges.where(badge_id: Badge.where(option: level).ids).order(created_at: :asc).last.created_at
      user_tests_by_rule = @user.test_passages.success.where(test_id: tests_by_rule).where("created_at > ?", last_badge_date)
    end

    tests_by_rule.count == user_tests_by_rule.pluck(:test_id).uniq.count
  end


  def self.badge_rules
    [ :first_attempt, :tests_by_category_finished, :tests_by_level_finished ]
  end

  def self.badge_titles
    [ :first_try, :first_try_100,
      :category, :category_100,
      :level, :level_100 ]
  end

end
