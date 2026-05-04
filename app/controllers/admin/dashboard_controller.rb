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

    plots_with_coverage = Plot.where(status: "planted").where.not(native_plant_coverage_percent: nil).where.not(square_footage: [nil, 0])
    weighted_sum = plots_with_coverage.sum("square_footage * native_plant_coverage_percent")
    total_sq_ft = plots_with_coverage.sum(:square_footage)
    @native_coverage_percent = total_sq_ft > 0 ? (weighted_sum / total_sq_ft * 100).round : nil
  end

  private

  def require_admin
    unless session[:admin_id] && Admin.exists?(session[:admin_id])
      redirect_to admin_login_path
    end
  end
end
