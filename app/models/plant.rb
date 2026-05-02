class Plant < ApplicationRecord
  has_many :plots_plants, dependent: :destroy
  has_many :plots, through: :plots_plants

  before_validation :titlecase_names

  private

  def titlecase_names
    self.name = name.titlecase if name.present?
    self.latin_name = latin_name.titlecase if latin_name.present?
  end
end
