class PlotsController < ApplicationController
  def show
    @plot = Plot.includes(:photos).find_by!(slug: params[:slug])
  end
end
