class PagesController < ApplicationController
  def home
    @plots = Plot.where(status: "planted").includes(:photos).order(:first_planted)
  end

  def old
  end
end
