class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks.all.order(status: :desc).order(created_at: :desc).page(params[:page]).per(5)
  end
  
  def show
    
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクの追加が完了しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクの追加に失敗しました'
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = 'タスクの変更が完了しました'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'タスクの変更に失敗しました'
      render :edit
    end
  end
  
  def destroy
    
    @task.destroy
    
    flash[:success] = 'タスクを消去しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
   # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
