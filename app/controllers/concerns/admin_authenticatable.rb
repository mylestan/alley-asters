module AdminAuthenticatable
  extend ActiveSupport::Concern

  private

  def require_admin
    unless current_user&.is_admin?
      redirect_to admin_login_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
