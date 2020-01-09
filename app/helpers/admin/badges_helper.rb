module Admin::BadgesHelper
  def badge_rules
    BadgeService.badge_rules
  end
  def badge_titles
    BadgeService.badge_titles
  end
end