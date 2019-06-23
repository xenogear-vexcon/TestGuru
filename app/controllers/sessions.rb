class Users::SessionsController < Devise::SessionsController

  def create
    super
    flash[:notice] = "Welcome, #{current_user.full_name}"
  end

end