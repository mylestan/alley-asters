class Admin::SessionsController < ApplicationController
  layout "admin"

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      if user.is_admin?
        session[:user_id] = user.id
        redirect_to admin_root_path
      else
        flash.now[:alert] = "You do not have admin access"
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to admin_login_path
  end
end
