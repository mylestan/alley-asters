class User < ApplicationRecord
  has_secure_password
  has_many :task_completions, dependent: :destroy
  has_many :completed_tasks, through: :task_completions, source: :task

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
