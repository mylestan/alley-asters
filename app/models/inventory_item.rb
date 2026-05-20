class InventoryItem < ApplicationRecord
  STATUSES = %w[ready not_ready].freeze

  belongs_to :plant

  validates :status, inclusion: { in: STATUSES }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
