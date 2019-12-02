module Admin::BadgesHelper
  def badge_rules
    [["First try", :first_attempt], ["All tests in category", :tests_by_category_finished], ["All tests by level", :tests_by_level_finished]]
  end

  def badge_title
    [ 'First try', 'First try with 100% result',
      'All tests in category', 'All tests in category with 100% result',
      'All tests by level', 'All tests by level with 100% result' ]
  end
end