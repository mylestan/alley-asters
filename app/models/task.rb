class Task < ApplicationRecord
  belongs_to :plot
  has_many :task_completions, dependent: :destroy
  has_many :completers, through: :task_completions, source: :user
  has_many :task_tools, dependent: :destroy
  has_many :tools, through: :task_tools

  def completed?
    completed_at.present?
  end

  def required_tools
    tools.joins(:task_tools).where(task_tools: { requirement: "required" })
  end

  def suggested_tools
    tools.joins(:task_tools).where(task_tools: { requirement: "suggested" })
  end
end
