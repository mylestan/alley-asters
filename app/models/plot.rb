class Plot < ApplicationRecord
  STATUSES = %w[potential planned planted].freeze

  has_many :plots_plants, dependent: :destroy
  has_many :plants, through: :plots_plants
  has_many :photos, dependent: :destroy

  validates :status, inclusion: { in: STATUSES }

  def self.by_address
    all.sort_by do |plot|
      if plot.name.match(/^(\d+)\s+(.+)$/)
        [0, $2, $1.to_i]
      else
        [1, plot.name, 0]
      end
    end
  end

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

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

    # Match @lat,lng or !3d{lat}!4d{lng} patterns
    if expanded.match(/@(-?\d+\.\d+),(-?\d+\.\d+)/)
      { latitude: $1.to_f, longitude: $2.to_f }
    elsif expanded.match(/!3d(-?\d+\.\d+)!4d(-?\d+\.\d+)/)
      { latitude: $1.to_f, longitude: $2.to_f }
    end
  rescue StandardError
    nil
  end

  private

  def generate_slug
    self.slug = name.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/^-|-$/, "")
  end
end
