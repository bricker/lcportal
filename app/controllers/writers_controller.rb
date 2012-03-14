class WritersController < ApplicationController
  before_filter :require_admin
  before_filter :get_writer, only: [:show, :edit, :update, :destroy]
  respond_to :html
  
  def index
    @writers = Writer.order('name')
  end
  
  def new
    @writer = Writer.new
  end
  
  def create
    @writer = Writer.new(params[:writer])
    flash[:notice] = "Added Writer" if @writer.save
    respond_with @writer
  end
  
  def update
    flash[:notice] = "Updated Writer Profile" if @writer.update_attributes(params[:writer])
    respond_with @writer  
  end
  
  def destroy
    flash[:notice] = "Removed Writer" if @writer.destroy
    respond_with @writer
  end
  
  private
    def get_writer
      @writer = Writer.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to writers_path, alert: "Writer not found."
    end
end