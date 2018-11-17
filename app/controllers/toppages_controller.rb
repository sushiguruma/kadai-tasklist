class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tasks = current_user.tasks.order('status DESC').order('created_at DESC').page(params[:page]).per(5)
    end
  end
end
