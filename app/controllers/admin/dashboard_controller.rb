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
    planted_plants = Plant.joins(:plots_plants).distinct
    @total_native_plants = planted_plants.where(is_native: true).count
    @total_cultivars = planted_plants.where(cultivar: true).count
    @total_invasive_plants = planted_plants.where(invasive: true).count
    @total_nativars = planted_plants.where(nativar: true).count

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
