class StatementsController < ApplicationController
  before_filter :require_admin, except: :index
  
  def index
    @statements = Statement.recent_first.page(params[:page]).per(5)
  end
  
  def download
    @statement = Statement.find(params[:id])
    redirect_to @statement.authenticated_asset_url
    rescue
      redirect_to statements_path, alert: "Statement not found."
  end
end
