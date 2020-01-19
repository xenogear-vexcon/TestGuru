module Admin::BadgesHelper
  def badge_rules
    BadgeService.badge_rules.map{|rule| [t(".#{rule}"), rule]}
  end

  def badge_titles
    BadgeService.badge_titles.map{|title| [t(".#{title}"), title]}
  end
  def option
    BadgeService.option{|option| [t(".#{option}"), option]}
  end
end