class Admin::DashboardController < ApplicationController
  layout "admin"
  before_action :require_admin

  def index
    @total_plots = Plot.count
    @planted_count = Plot.where(status: "planted").count
    @planned_count = Plot.where(status: "planned").count
    @potential_count = Plot.where(status: "potential").count
    @total_square_footage = Plot.where(status: "planted").sum(:square_footage)
    @total_plants_planted = Plot.where(status: "planted").sum(:initial_plant_count) + Plot.where(status: "planted").sum(:added_plant_count)
    @distinct_native_plants = Plant.where(is_native: true).joins(:plots_plants).distinct.count
  end

  private

  def require_admin
    unless session[:admin_id] && Admin.exists?(session[:admin_id])
      redirect_to admin_login_path
    end
  end
end
