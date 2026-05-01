class Plant < ApplicationRecord
  has_many :plots_plants, dependent: :destroy
  has_many :plots, through: :plots_plants
end
