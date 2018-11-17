class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tasks_not_done = current_user.tasks.where(status: '未実行').order('created_at DESC').page(params[:page]).per(5)
    end
  end
end
