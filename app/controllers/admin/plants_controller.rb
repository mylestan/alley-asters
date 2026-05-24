class Admin::PlantsController < ApplicationController
  include AdminAuthenticatable
  layout "admin"
  before_action :require_admin

  def index
    @plants = Plant.order(:name)
    @plant = Plant.new

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv, filename: "plants-#{Date.today}.csv", type: "text/csv" }
    end
  end

  def create
    @plant = Plant.new(plant_params)
    if @plant.save
      redirect_to admin_plants_path, notice: "Plant added."
    else
      @plants = Plant.order(:name)
      flash.now[:alert] = @plant.errors.full_messages.join(", ")
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def update
    @plant = Plant.find(params[:id])
    if @plant.update(plant_params)
      redirect_to admin_plants_path, notice: "Plant updated."
    else
      flash.now[:alert] = @plant.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Plant.find(params[:id]).destroy
    redirect_to admin_plants_path, notice: "Plant removed."
  end

  private

  def generate_csv
    require "csv"
    plant_ids_in_plots = PlotsPlant.distinct.pluck(:plant_id).to_set
    plants = Plant.order(:latin_name).sort_by { |p| [plant_ids_in_plots.include?(p.id) ? 0 : 1, p.latin_name.to_s.downcase] }

    CSV.generate(headers: true) do |csv|
      csv << ["Common Name", "Latin Name", "In Plot"]
      plants.each do |plant|
        csv << [plant.name, plant.latin_name, plant_ids_in_plots.include?(plant.id) ? "Yes" : "No"]
      end
    end
  end

  def plant_params
    params.require(:plant).permit(:name, :latin_name, :is_native, :invasive, :nativar, :cultivar, :endangered, :canopy_layer)
  end
end
