class PagesController < ApplicationController
  def home
    @plots = Plot.where(status: "planted").includes(:photos).order(:first_planted)
    @total_plots = @plots.count
    @total_square_footage = @plots.sum(:square_footage)
    @total_plants_planted = @plots.sum(:initial_plant_count) + @plots.sum(:added_plant_count)
    @distinct_native_plants = Plant.where(is_native: true).joins(:plots_plants).distinct.count
  end

  def old
  end
end
