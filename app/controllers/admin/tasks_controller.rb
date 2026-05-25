class Admin::TasksController < ApplicationController
  include AdminAuthenticatable
  layout "admin"
  before_action :require_admin
  before_action :set_task, only: %i[edit update destroy]

  def index
    @tasks = Task.includes(:plot, :completers).order(completed_at: :asc, created_at: :desc)
  end

  def new
    @task = Task.new
    @plots = Plot.by_address
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      sync_tools(@task)
      redirect_to admin_tasks_path, notice: "Task created."
    else
      @plots = Plot.by_address
      flash.now[:alert] = @task.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plots = Plot.by_address
  end

  def update
    if @task.update(task_params)
      sync_tools(@task)
      redirect_to admin_tasks_path, notice: "Task updated."
    else
      @plots = Plot.by_address
      flash.now[:alert] = @task.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to admin_tasks_path, notice: "Task deleted."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def sync_tools(task)
    task.task_tools.destroy_all
    (params[:required_tool_ids] || []).reject(&:blank?).each do |tool_id|
      task.task_tools.create!(tool_id: tool_id, requirement: "required")
    end
    (params[:suggested_tool_ids] || []).reject(&:blank?).each do |tool_id|
      task.task_tools.create!(tool_id: tool_id, requirement: "suggested")
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :plot_id, :completed_at, :completion_notes)
  end
end
