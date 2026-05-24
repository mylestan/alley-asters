class ProfilesController < ApplicationController
  before_action :require_login

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to profile_path, notice: "Profile updated."
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def require_login
    redirect_to login_path unless logged_in?
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :street_address, :city, :state, :zip, :latitude, :longitude, :instagram_handle)
  end
end
