class UserTasksController < ApplicationController
  before_action :require_login

  def index
    @tasks = Task.where(completed_at: nil).includes(:plot, :task_tools, :tools).order(created_at: :desc)
    @distances = {}

    if current_user.latitude.present? && current_user.longitude.present?
      @tasks.each do |task|
        if task.plot.latitude.present? && task.plot.longitude.present?
          @distances[task.id] = haversine_feet(
            current_user.latitude, current_user.longitude,
            task.plot.latitude, task.plot.longitude
          )
        end
      end

      @tasks = @tasks.sort_by { |t| @distances[t.id] || Float::INFINITY }
    end
  end

  def tools
    @self_serve_tools = Tool.where(self_serve: true).order(:name)
    @by_request_tools = Tool.where(by_request: true).order(:name)
  end

  def complete
    @task = Task.find(params[:id])
    @users = User.where.not(id: current_user.id).order(:email)
  end

  def submit_completion
    @task = Task.find(params[:id])
    @task.update!(
      completed_at: Time.current,
      completion_notes: params[:completion_notes]
    )

    # Add current user as completer
    TaskCompletion.find_or_create_by!(task: @task, user: current_user)

    # Add additional completers
    (params[:completer_ids] || []).reject(&:blank?).each do |user_id|
      TaskCompletion.find_or_create_by!(task: @task, user_id: user_id)
    end

    redirect_to user_tasks_path, notice: "Task marked as completed!"
  end

  private

  def require_login
    redirect_to login_path unless logged_in?
  end

  def haversine_feet(lat1, lng1, lat2, lng2)
    r = 20_902_231 # Earth's radius in feet
    dlat = to_rad(lat2.to_f - lat1.to_f)
    dlng = to_rad(lng2.to_f - lng1.to_f)
    a = Math.sin(dlat / 2)**2 + Math.cos(to_rad(lat1.to_f)) * Math.cos(to_rad(lat2.to_f)) * Math.sin(dlng / 2)**2
    r * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  end

  def to_rad(deg)
    deg * Math::PI / 180
  end
end
