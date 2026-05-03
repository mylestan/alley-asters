class PagesController < ApplicationController
  def home
    planted = Plot.where(status: "planted")
    @plots = planted.includes(:photos).order(:first_planted)
    @total_plots = planted.count
    @total_square_footage = planted.sum(:square_footage)
    @total_plants_planted = planted.sum(:initial_plant_count) + planted.sum(:added_plant_count)
    @distinct_native_plants = Plant.where(is_native: true).joins(:plots_plants).distinct.count
  end

  def old
  end
end
