class Admin::PlotsController < ApplicationController
  layout "admin"
  before_action :require_admin
  before_action :set_plot, only: %i[edit update destroy]

  def index
    @status_filter = params[:status]
    plots = @status_filter.present? ? Plot.where(status: @status_filter) : Plot.all
    @plots = plots.by_address
  end

  def new
    @plot = Plot.new
    @plants = Plant.order(:name)
  end

  def create
    @plot = Plot.new(plot_params)
    apply_google_maps_coords(@plot)

    if @plot.save
      redirect_to edit_admin_plot_path(@plot), notice: "Plot created."
    else
      @plants = Plant.order(:name)
      flash.now[:alert] = @plot.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plants = Plant.order(:name)
  end

  def destroy
    @plot.destroy
    redirect_to admin_plots_path, notice: "Plot deleted."
  end

  def update
    @plot.assign_attributes(plot_params)
    apply_google_maps_coords(@plot)

    if @plot.save
      redirect_to edit_admin_plot_path(@plot), notice: "Plot updated."
    else
      @plants = Plant.order(:name)
      flash.now[:alert] = @plot.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def require_admin
    unless session[:admin_id] && Admin.exists?(session[:admin_id])
      redirect_to admin_login_path
    end
  end

  def set_plot
    @plot = Plot.find_by!(slug: params[:id])
  end

  def apply_google_maps_coords(plot)
    url = params[:google_maps_url]
    return if url.blank?

    coords = Plot.coords_from_google_maps_url(url)
    if coords
      plot.latitude = coords[:latitude]
      plot.longitude = coords[:longitude]
    end
  end

  def plot_params
    params.require(:plot).permit(
      :name, :address, :sub_location, :square_footage, :first_planted,
      :initial_plant_count, :added_plant_count, :native_plant_coverage_percent,
      :notes, :plants_removed, :managed_by_us, :has_signage, :status,
      plant_ids: []
    )
  end
end
