class Admin::ToolsController < ApplicationController
  include AdminAuthenticatable
  layout "admin"
  before_action :require_admin

  def index
    @tools = Tool.order(:name)
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      redirect_to admin_tools_path, notice: "Tool added."
    else
      @tools = Tool.order(:name)
      flash.now[:alert] = @tool.errors.full_messages.join(", ")
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    Tool.find(params[:id]).destroy
    redirect_to admin_tools_path, notice: "Tool removed."
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :photo, :self_serve, :by_request)
  end
end
