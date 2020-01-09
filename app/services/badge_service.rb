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

  def tests_by_category_finished?(category_id, badge_id)
    return unless @test_passage.success? && category_id.to_i == @test.category_id

    tests_by_category = Test.where(category_id: category_id.to_i)
    user_tests_by_category = @user.test_passages.success.where(test_id: tests_by_category)

    if @user.user_badges.where(badge_id: badge_id.to_i).any?
      last_badge_date = @user.user_badges.where(badge_id: badge_id.to_i).order(created_at: :asc).last.created_at
      user_tests_by_category = user_tests_by_category.where("created_at > ?", last_badge_date)
    end
    tests_by_category.pluck(:id).count == user_tests_by_category.pluck(:id).uniq.count
  end

  def first_attempt?(option, badge_id)
    return unless @test_passage.success?

    TestPassage.where(user_id: @user.id, test_id: @test.id).success.count == 1
  end

  def tests_by_level_finished?(level, badge_id)
    return unless @test_passage.success? && level.to_i == @test.level

    tests_by_level = Test.where(level: level.to_i).count
    user_tests_by_level = @user.tests.where(level: level.to_i).count
    
    tests_by_level == user_tests_by_level
  end

  def self.badge_rules
    [ [ I18n.t('first_attempt'), :first_attempt ], [ I18n.t('category'), :tests_by_category_finished ], [ I18n.t('level'), :tests_by_level_finished ] ]
  end

  def self.badge_titles
    [ I18n.t('.first_try'), I18n.t('.first_try_100'),
      I18n.t('.category'), I18n.t('.category_100'),
      I18n.t('.level'), I18n.t('.level_100') ]
  end

end