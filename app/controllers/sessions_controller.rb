class SessionsController < ApplicationController
  def new
  end

  def create
    name = params[:session][:name]
    email= params[:session][:email].downcase
    password = params[:session][:password]
    
    if login(name, email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to root_url
    else
      flash[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  def login(name, email, password)
    @user = User.find_by(name: name, email: email)
    if @user&&@user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
  
end
