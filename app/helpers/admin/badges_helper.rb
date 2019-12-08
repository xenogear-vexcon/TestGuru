module Admin::BadgesHelper
  def badge_rules
    [ [ t('.first_try'), :first_attempt ], [ t('.category'), :tests_by_category_finished ], [ t('.level'), :tests_by_level_finished ] ]
  end

  def badge_title
    [ t('.first_try'), t('.first_try_100'),
      t('.category'), t('.category_100'),
      t('.level'), t('.level_100') ]
  end
end