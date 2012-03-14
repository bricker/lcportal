class StatementsController < ApplicationController
  before_filter :require_admin, except: :index
  
  def index
    @statements = Statement.recent_first.page(params[:page]).per(5)
  end
end
