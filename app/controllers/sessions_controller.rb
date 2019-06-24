class SessionsController < Devise::SessionsController
  def create
    super
    flash[:success] = "Welcome, #{current_user.name}!"
  end
end