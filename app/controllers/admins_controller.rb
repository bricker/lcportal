class AdminsController < ApplicationController
  before_filter :require_admin
  before_filter :get_admin, only: [:show, :edit, :update, :delete]
  respond_to :html
  
  def index
    @admins = Admin.all
  end
  
  def new
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(params[:admin])
    flash[:notice] = "Added Admin. A welcome e-mail has been sent to the user." if @admin.save
    respond_with @admin
  end
  
  def update
    flash[:notice] = "Updated Admin." if @admin.update_attributes(params[:admin])
    respond_with @admin
  end
  
  def delete
    flash[:notice] = "Removed Admin." if @admin.destroy
    respond_with @admin
  end
  
  protected
    def get_admin
      @admin = Admin.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to admins_path, alert: "Admin not found."
    end
end