class Admin::PhotosController < ApplicationController
  layout "admin"
  before_action :require_admin

  def create
    plot = Plot.find_by!(slug: params[:plot_id])
    photo = plot.photos.build(photo_params)

    if photo.save
      redirect_to edit_admin_plot_path(plot.slug), notice: "Photo added."
    else
      redirect_to edit_admin_plot_path(plot.slug), alert: photo.errors.full_messages.join(", ")
    end
  end

  def update
    photo = Photo.find(params[:id])
    photo.update(photo_update_params)
    redirect_to edit_admin_plot_path(photo.plot.slug), notice: "Photo updated."
  end

  def destroy
    photo = Photo.find(params[:id])
    plot = photo.plot
    photo.destroy
    redirect_to edit_admin_plot_path(plot.slug), notice: "Photo removed."
  end

  private

  def require_admin
    unless session[:admin_id] && Admin.exists?(session[:admin_id])
      redirect_to admin_login_path
    end
  end

  def photo_params
    params.require(:photo).permit(:image, :caption, :position)
  end

  def photo_update_params
    params.require(:photo).permit(:caption, :position)
  end
end
