class BadgesController < ApplicationController

  def index
    @user_badges = current_user.badges
    @badges = Badge.where.not(id: @user_badges.ids)
  end

end
