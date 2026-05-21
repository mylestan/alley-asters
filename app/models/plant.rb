class Plant < ApplicationRecord
  CANOPY_LAYERS = %w[ground shrub understory canopy].freeze

  has_many :plots_plants, dependent: :destroy
  has_many :plots, through: :plots_plants
  has_many :inventory_items, dependent: :destroy

  validates :canopy_layer, inclusion: { in: CANOPY_LAYERS }

  validates :name, uniqueness: { case_sensitive: false, message: "already exists" }, if: -> { name.present? }
  validates :latin_name, uniqueness: { case_sensitive: false, message: "already exists" }, allow_blank: true

  before_validation :titlecase_names

  private

  def titlecase_names
    self.name = name.titlecase if name.present?
    self.latin_name = latin_name.titlecase if latin_name.present?
  end
end
