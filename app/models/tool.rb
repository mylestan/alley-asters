class Tool < ApplicationRecord
  has_many :task_tools, dependent: :destroy
  has_many :tasks, through: :task_tools
  has_one_attached :photo

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
