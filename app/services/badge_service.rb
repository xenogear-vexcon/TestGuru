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

    if @user.user_badges.where(badge_id: badge_id.to_i).empty?
      tests_by_category = Test.where(category_id: category_id.to_i).pluck(:id)
      # success tests array by test_id
      user_tests_by_category = @user.test_passages.success.where(test_id: tests_by_category).pluck(:test_id)

      tests_by_category.count == user_tests_by_category.uniq.count
    else
      tests_by_category = Test.where(category_id: category_id.to_i).pluck(:id)
      # last badge date
      last_badge_date = @user.user_badges.where(badge_id: badge_id.to_i).reorder(created_at: :asc).last.created_at
      # success tests array by test_id after last badge date
      last_user_tests_by_category = @user.test_passages
                                         .success
                                         .where(test_id: tests_by_category)
                                         .where("created_at > ?", last_badge_date)
                                         .pluck(:test_id)

      tests_by_category.count == last_user_tests_by_category.uniq.count
    end
  end

  def first_attempt?(option, badge_id)
    test_passage_success? && TestPassage.where(user_id: @user.id, test_id: @test.id).success.count == 1
  end
      

    # @category_array = Test.where(category: category_id).pluck(:id)                                   # [2, 1]
    # user_tests_array = @user.test_passages.success.where(test_id: category_array).pluck(:test_id)   # [2, 1, 2, 1]

    # user_tests_array.inject(Hash.new{ 0 }){ |result, i| result[i] += 1 result}

    # if user_tests_array.any?
    #   associative_array = user_tests_array.uniq.map{ |i| [i, user_tests_array.find_all{ |j| j == i }.size] }     # [[2, 2], [1, 2]]
    #   sum = associative_array.inject(0){|result, a| result + a[1]}
    #   sum % category_array.count == 0
    # end

    # пункт - сравнить массив тестов по категории с наличием обоих тестов в пассаджах.
    # проверить есть ли уже такой бейдж?
    # если есть, проверить сданные тесты после даты получения бейджа

  def tests_by_level_finished?(level, badge_id)
    tests_by_level = Test.where(level: level.to_i).count
    user_tests_by_level = @user.tests.where(level: level.to_i).count
    
    test_passage_success? && (tests_by_level == user_tests_by_level)
  end

  def test_passage_success?
    @test_passage.success?
  end

end
