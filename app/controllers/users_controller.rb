class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        flash[:success] = 'ユーザー登録が完了しました。'
        redirect_to @user
      else
        flash[:danger] = 'ユーザー登録に失敗しました。'
        render :new
      end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を更新しました。'
      redirect_to edit_user_path
    else
      flash[:danger] = 'ユーザー情報の更新に失敗しました。'
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザーを削除しました。'
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
