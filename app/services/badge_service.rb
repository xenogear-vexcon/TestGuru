class BadgeService

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def call
    Badge.all.select { |badge| send("#{badge.rule}?", badge.option, badge.id) }
  end

  private

  def check_badge_rule(rule, badge_id)
    return unless @test_passage.success? && rule.to_i == @test.rule

    tests_by_rule = Test.where(rule: rule.to_i)
    user_tests_by_rule = @user.test_passages.success.where(rule: tests_by_rule)

    if @user.user_badges.where(badge_id: badge_id.to_i).any?
      last_badge_date = @user.user_badges.where(badge_id: badge_id.to_i).order(created_at: :asc).last.created_at
      user_tests_by_rule = user_tests_by_rule.where("created_at > ?", last_badge_date)
    end

    tests_by_rule.pluck(:id).count == user_tests_by_rule.pluck(:id).uniq.count
  end

  def first_attempt?(option, badge_id)
    return unless @test_passage.success?

    TestPassage.where(user_id: @user.id, test_id: @test.id).success.count == 1
  end

  def tests_by_level_finished?(level, badge_id)
    check_badge_rule(level, badge_id)
  end

  def tests_by_category_finished?(category_id, badge_id)
    check_badge_rule(category_id, badge_id)
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
