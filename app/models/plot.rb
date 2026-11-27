class Plot < ApplicationRecord
  STATUSES = %w[potential planned planted].freeze

  has_many :plots_plants, dependent: :destroy
  has_many :plants, through: :plots_plants
  has_many :photos, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :status, inclusion: { in: STATUSES }

  before_validation :generate_slug
  before_save :set_first_planted_when_planted

  def display_name
    parts = [ address, sub_location.present? ? "(#{sub_location})" : nil ].compact.join(" ")
    parts.present? ? parts : name
  end

  def self.by_address
    all.sort_by do |plot|
      addr = plot.address || ""
      if addr.match(/^(\d+)\s+(.+)$/)
        [ 0, $2, $1.to_i, plot.sub_location.to_s ]
      else
        [ 1, plot.display_name, 0, "" ]
      end
    end
  end

  # Newest first planted first; plots with no date go last, in address order.
  def self.by_first_planted_desc
    by_address.each_with_index.sort_by do |plot, i|
      [ plot.first_planted ? 0 : 1, -(plot.first_planted&.jd || 0), i ]
    end.map(&:first)
  end

  def to_param
    slug
  end

  def self.coords_from_google_maps_url(url)
    return nil if url.blank?

    require "net/http"
    uri = URI.parse(url)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: 5, read_timeout: 5) do |http|
      http.get(uri.request_uri)
    end

    expanded = response["location"] || url

    # Prefer !3d/!4d (exact place coords) over @ (viewport center)
    if expanded.match(/!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)/)
      { latitude: $1.to_f, longitude: $2.to_f }
    elsif expanded.match(/@(-?\d+\.\d+),(-?\d+\.\d+)/)
      { latitude: $1.to_f, longitude: $2.to_f }
    end
  rescue StandardError
    nil
  end

  private

  # When a plot is switched to planted and has no first planted date yet,
  # use today's date (Central time, where the plots are).
  def set_first_planted_when_planted
    return unless status == "planted" && will_save_change_to_status? && first_planted.blank?

    self.first_planted = Time.find_zone("Central Time (US & Canada)").today
  end

  def generate_slug
    source = display_name
    return if source.blank?
    self.slug = source.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/^-|-$/, "")
  end
end
