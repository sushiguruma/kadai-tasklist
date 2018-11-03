class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @tasks = Task.find(params[:id])
  end
  
  def new
    @tasks = Task.new
  end
  
  def create
    @tasks = Task.new(task_params)
    
    if @tasks.save
      flash[:success] = 'タスクの追加が完了しました。'
      redirect_to tasks_url
    else
      flash.now[:danger] = 'タスクの追加に失敗しました'
      render :new
    end
  end
  
  def edit
    @tasks = Task.find(params[:id])
  end
  
  def update
    @tasks = Task.find(params[:id])
    
    if @tasks.update(task_params)
      flash[:success] = 'タスクの変更が完了しました'
      redirect_to tasks_url
    else
      flash[:danger] = 'タスクの変更に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'タスクを消去しました。'
    redirect_to tasks_url
  end
  
  private
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content)
  end
  
end
