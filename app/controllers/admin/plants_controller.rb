class Admin::PlantsController < ApplicationController
  layout "admin"
  before_action :require_admin

  def index
    @plants = Plant.order(:name)
    @plant = Plant.new
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

  def require_admin
    unless session[:admin_id] && Admin.exists?(session[:admin_id])
      redirect_to admin_login_path
    end
  end

  def plant_params
    params.require(:plant).permit(:name, :latin_name, :is_native, :invasive, :nativar, :cultivar, :endangered)
  end
end
