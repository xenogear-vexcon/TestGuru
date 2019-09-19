class BadgeService

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
    @badges = Badge.where.not(id: @user.badges.ids)
  end

  def call
    Badge.all.select do |badge|
      send("#{badge.rule}?", badge.rule)
    end
  end

  private

  def first_attempt?(_params)
    @user.test_passages.where(test: @test).count == 1
  end

  def tests_by_category_finished?(category)
    return unless category == @test.category.title

    ids = Test.sort_by_category(category).ids
    ids.count == @user.test_passages.where(test_id: ids)
  end

  def tests_by_level_finished?(level)
    return unless level.to_i == @test.level

    ids = Test.where(level: level).ids
    ids.count == @user.test_passages.where(test_id: ids)
  end
end