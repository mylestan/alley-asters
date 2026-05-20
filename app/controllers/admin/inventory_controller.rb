class Admin::InventoryController < ApplicationController
  layout "admin"
  before_action :require_admin

  def index
    @items = InventoryItem.includes(:plant).joins(:plant).order("plants.name")
    @item = InventoryItem.new
    @plants = Plant.order(:name)
    @total_ready = InventoryItem.where(status: "ready").sum(:quantity)
    @total_not_ready = InventoryItem.where(status: "not_ready").sum(:quantity)
  end

  def create
    @item = InventoryItem.new(item_params)
    if @item.save
      redirect_to admin_inventory_path, notice: "Item added."
    else
      @items = InventoryItem.includes(:plant).joins(:plant).order("plants.name")
      @plants = Plant.order(:name)
      @total_ready = InventoryItem.where(status: "ready").sum(:quantity)
      @total_not_ready = InventoryItem.where(status: "not_ready").sum(:quantity)
      flash.now[:alert] = @item.errors.full_messages.join(", ")
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @item = InventoryItem.find(params[:id])
    @plants = Plant.order(:name)
  end

  def update
    @item = InventoryItem.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_inventory_path, notice: "Item updated."
    else
      @plants = Plant.order(:name)
      flash.now[:alert] = @item.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    InventoryItem.find(params[:id]).destroy
    redirect_to admin_inventory_path, notice: "Item removed."
  end

  private

  def require_admin
    unless session[:admin_id] && Admin.exists?(session[:admin_id])
      redirect_to admin_login_path
    end
  end

  def item_params
    params.require(:inventory_item).permit(:plant_id, :quantity, :status)
  end
end
