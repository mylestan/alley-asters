class TaskTool < ApplicationRecord
  REQUIREMENTS = %w[required suggested].freeze

  belongs_to :task
  belongs_to :tool

  validates :requirement, inclusion: { in: REQUIREMENTS }
end
